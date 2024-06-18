class UpdatePatientTable < ActiveRecord::Migration[7.1]
  def change
    # Change columns to bigint
    change_column :patients, :user_id, :bigint
    change_column :patients, :receptionist_id, :bigint
    change_column :patients, :doctor_id, :bigint

    # Remove registerperson column (if previously added)
    remove_column :patients, :registerperson, :string

    # Add foreign keys only if they do not exist
    add_foreign_key :patients, :users, column: :user_id unless foreign_key_exists?(:patients, :users, :user_id)
    add_foreign_key :patients, :users, column: :receptionist_id unless foreign_key_exists?(:patients, :users, :receptionist_id)
    add_foreign_key :patients, :doctors, column: :doctor_id unless foreign_key_exists?(:patients, :doctors, :doctor_id)
  end

  def foreign_key_exists?(table, to_table, column)
    foreign_keys = ActiveRecord::Base.connection.foreign_keys(table)
    foreign_keys.any? { |fk| fk.to_table == to_table.to_s && fk.column == column.to_s }
  end
end
