class UpdateUsers < ActiveRecord::Migration
    def self.up
        change_table :users do |t|
            t.column :subtasks_default_expand_limit_upper, :integer, :default => 0, :null => false
        end
    end

    def self.down
        change_table :users do |t|
            t.remove :subtasks_default_expand_limit_upper
        end
    end
end
