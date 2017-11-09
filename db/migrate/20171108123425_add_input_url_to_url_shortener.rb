class AddInputUrlToUrlShortener < ActiveRecord::Migration[5.1]
  def change
    add_column :url_shorteners, :input_url, :string
  end
end
