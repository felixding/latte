class Page < ActiveRecord::Base
  versioned
  has_ancestry

  belongs_to :project, :class_name => "Project", :foreign_key => "project_id"
  belongs_to :creator, :class_name => "User", :foreign_key => "creator_id"
  belongs_to :updater, :class_name => "User", :foreign_key => "updater_id"
  
  validates_presence_of :project_id
  validates_presence_of :creator_id
  validates_presence_of :updater_id, :on => :update
  validates_presence_of :title, :on => :save
  #validates_presence_of :body, :on => :update
  validates_each :index_id do |model, attr, value|
    #model.errors.add(:index_id, "Pages with same index_ids are not allowed.") if Page.exists?(project_id: model.project_id, index_id: model.index_id)
  end
  
  attr_accessible :title, :body

end