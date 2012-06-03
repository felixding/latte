class Edition < ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => "creator_id"
  belongs_to :project, :class_name => "Project", :foreign_key => "project_id"
  
  attr_accessible :name, :intro
  serialize :pages
  
  validates_presence_of :creator_id
  validates_presence_of :project_id
  validates_presence_of :project_version
  validates_presence_of :pages
  validates_presence_of :name
  
  before_validation do |edtion|
    edtion.creator_id = edtion.project.creator_id
    edtion.project_version = edtion.project.version
    edtion.pages = edtion.project.pages.collect{|page| [page.id, page.version]}
  end
  
  def versioned_project
    self.project.revert_to self.project_version
    
    self.project
  end
  
  def versioned_pages
    self.pages.collect do |page_id, page_version|
      Page.find_by_id_and_version_or_restore_from_history(page_id, page_version)
    end
  end
  
end