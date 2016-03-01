class RolifyCreateRoles < ActiveRecord::Migration
  def change
    create_table(:roles) do |t|
      t.string :name
      t.string :label
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:users_roles, :id => false) do |t|
      t.references :user
      t.references :role
    end

    add_index(:roles, :name)
    add_index(:roles, [:name, :resource_type, :resource_id])
    add_index(:users_roles, [:user_id, :role_id])

    {
      "Admin" => 'admin',
      "Candidate" => 'candidate',
      "Consulting Company" => 'consultant',
      "Hiring Manager" => 'hm'
    }.each do |label, name|
      Role.create(name: name, label: label)
    end

  end

end
