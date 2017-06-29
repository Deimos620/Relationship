class ChangeColumnTypeToTitleTypeInTitle < ActiveRecord::Migration
  def change
    rename_column :titles, :type, :title_type
  end
end
