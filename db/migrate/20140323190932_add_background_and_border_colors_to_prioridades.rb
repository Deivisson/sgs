class AddBackgroundAndBorderColorsToPrioridades < ActiveRecord::Migration
  def change
  	add_column :prioridades, :background_color, :string, :null => false, :default => "#fff"
  	add_column :prioridades, :border_color, :string, :null => false, :default => "#fff"
  	add_column :prioridades, :font_color, :string, :null => false, :default => "#333333"
  end
end
