class CreateUrlShorteners < ActiveRecord::Migration[5.1]
  def change
    create_table :url_shorteners do |t|

      t.timestamps
    end
  end
end
