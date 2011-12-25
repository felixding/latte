class Edtion < ActiveRecord::Base
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
  
end