module Notion
  class PollDatabases < ApplicationInteractor
    def call 
      @account = context.account
      @client = Notion::Client.new(token: @account.configurable.access_token)
      @databases = @account.notion_databases
      
      return if @account.configurable_type != "NotionAccountConfiguration"

      @databases.each do |database|
        rows = retrieve_rows(database)
        next if rows.nil? || rows.empty?

        rows.each do |row|
          computed_hash = compute_row_hash(row)
          db_row = NotionRow.find_by_row_id(row.id)

          if db_row.nil?
            send_row_created_event(database, row, computed_hash)
            next
          end

          if computed_hash != db_row.object_hash
            send_row_updated_event(db_row, row, computed_hash)
          end
        end

        deleted_rows = retrieve_deleted_rows(database, rows)
        next if deleted_rows.empty?

        deleted_rows.each do |db_row|
          send_row_deleted_event(db_row)
        end
      end

    end

    private

    def retrieve_rows(database, cursor: nil)
      options = {database_id: database.database_id, page_size: 100}
      unless cursor.nil?
        options[:start_cursor] = cursor
      end

      begin
        rows = @client.database_query(options)
      rescue Notion::Api::Errors::ObjectNotFound
        database.destroy
        return 
      end

      unless rows.has_more
        return rows.results
      end

      return rows.results.concat(retrieve_rows(database, cursor: rows.next_cursor))
    end

    def retrieve_deleted_rows(database, rows)
      account_rows = NotionRow.where(notion_database: database).pluck(:row_id)
      notion_rows = rows.map {|r| r.id }
      deleted_rows = account_rows - notion_rows
      NotionRow.where(row_id: deleted_rows)
    end

    def compute_row_hash(row)
      Digest::SHA256.hexdigest(row.to_h.to_json)
    end

    def send_row_created_event(database, row, hash)
      ActiveRecord::Base.transaction do 
        NotionRow.create!(notion_database: database, 
                          row_id: row.id, object_hash: hash)
        Webhook.create!(account: @account, 
                        event_type: "database.row.created", payload: row.to_h)
      end
    end

    def send_row_updated_event(db_row, row, hash)
      ActiveRecord::Base.transaction do 
        update = db_row.update!(object_hash: hash)
        Webhook.create!(account: @account, event_type: "database.row.updated",
                        payload: row.to_h)
      end
    end

    def send_row_deleted_event(db_row)
      payload = {
        id: db_row.row_id
      }

      ActiveRecord::Base.transaction do 
        Webhook.create!(account: @account, event_type: "database.row.deleted", 
                        payload: payload)
        db_row.destroy!
      end
    end
  end
end
