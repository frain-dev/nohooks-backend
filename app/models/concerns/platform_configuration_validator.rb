class PlatformConfigurationValidator < ActiveModel::Validator
  def validate(record)
    case record.class.name
    when "NotionDatabase"
      verify_notion_configuration(record)
    when "RenderAccountConfiguration"
      verify_render_configuration(record)
    when "DigitalOceanAccountConfiguration"
      verify_digital_ocean_configuration(record)
    end
  end

  private 

  def verify_render_configuration(record)
    client = RenderRuby::Client.new(api_key: record.api_key)
    client.owners.list

  rescue RenderRuby::Error => e
    record.errors.add(:config, "invalid render api key")
  end

  def verify_digital_ocean_configuration(record)
    client = DropletKit::Client.new(access_token: record.access_token)
    client.account.info 

  rescue StandardError => e
    if e.message.starts_with?("401")
      record.errors.add(:config, "invalid digital ocean access token")
      return
    end

    record.errors.add(:config, "an error occurred validating your digital ocean config")
  end

  def verify_notion_configuration(record)
    client = Notion::Client.new(token: record.account.configurable.access_token)
    client.database_query(database_id: record.database_id)

  rescue Notion::Api::Errors::NotionError => e 
    if e.message.starts_with?("path failed validation")
      record.errors.add(:config, "#{record.database_id} is invalid")
      return
    end

    record.errors.add(:config,
                      "an error occurred validating your database id, please try again")
  end
end
