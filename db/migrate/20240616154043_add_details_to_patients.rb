class AddDetailsToPatients < ActiveRecord::Migration[7.1]
  def change
    add_column :patients, :registerperson, :string
    add_column :patients, :medical_history, :text
  end
end
