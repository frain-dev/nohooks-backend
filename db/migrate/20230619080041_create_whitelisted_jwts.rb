class CreateWhitelistedJwts < ActiveRecord::Migration[7.0]
  def change
    create_table :whitelisted_jwts, id: :uuid do |t|
      t.string :jti, null: false
      t.string :aud
      t.datetime :exp, null: false
      t.references :user, foreign_key: true, type: :uuid

      t.index :jti, unique: true

      t.timestamps
    end
  end
end
