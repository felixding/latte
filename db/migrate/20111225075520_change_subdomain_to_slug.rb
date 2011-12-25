class ChangeSubdomainToSlug < ActiveRecord::Migration
  def self.up
    rename_column :projects, :subdomain, :slug
  end

  def self.down
    rename_column :projects, :slug, :subdomain
  end
end
