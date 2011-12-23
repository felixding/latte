class Page < ActiveRecord::Base
  belongs_to :project, :class_name => "Project", :foreign_key => "project_id"
  belongs_to :creator, :class_name => "User", :foreign_key => "creator_id"
  belongs_to :updater, :class_name => "User", :foreign_key => "updater_id"
  #has_many :children, :class_name => "Page", :foreign_key => "parent_id"
  #belongs_to :parent, :class_name => "Page", :foreign_key => "parent_id"
  
  validates_presence_of :project_id
  validates_presence_of :creator_id
  validates_presence_of :updater_id, :on => :update
  validates_presence_of :title, :on => :save
  validates_presence_of :body, :on => :update
  
  attr_accessible :title, :body
  
  has_ancestry
  
  #def has_children?
    #!self.children.empty?
  #end

end