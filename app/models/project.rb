class Project < ActiveRecord::Base
  belongs_to :creator, :class_name => "User", :foreign_key => "creator_id"
  belongs_to :updater, :class_name => "User", :foreign_key => "updater_id"
  has_many :pages, :dependent => :destroy

  attr_reader :content_index
  attr_writer :content_index
  attr_accessible :name, :intro, :content_index
  
  INDENT_MARKER = "\-"
  
  validates_presence_of :name, :on => :save
  validates_presence_of :creator_id, :on => :create
  validates_presence_of :updater_id, :on => :save
  validates_presence_of :subdomain, :on => :create
  #validates_presence_of :content_index, :on => :save, :allow_nil => false, :allow_blank => false
  validates :content_index, :presence => true
  
  after_create do |project|
    previous_page_id = nil

    project.content_index.split("\n").each do |page_title|
      page_title = page_title.strip

      next if page_title.blank?
      
      page = project.pages.build(:title => page_title)
      page.creator_id = project.creator_id

      if page_title.match(/^#{INDENT_MARKER}/)
        page.title = page_title.gsub(/^#{INDENT_MARKER}*/, "")
        page.parent_id = previous_page_id
      end
        
      # save
      page.save!
      
      # update previous_page_id
      previous_page_id = page.id
    end
  end
  
  def to_param
    subdomain
  end

end