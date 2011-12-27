class Project < ActiveRecord::Base
  versioned
  INDENT_MARKER = "\-"

  belongs_to :creator, :class_name => "User", :foreign_key => "creator_id"
  belongs_to :updater, :class_name => "User", :foreign_key => "updater_id"
  has_many :pages, :dependent => :destroy
  has_many :editions, :class_name => "Edition", :dependent => :destroy
  
  def content_index=(value)
    @content_index = value
  end

  def content_index
    @content_index ||= self.pages.collect do |page|
      ((0..page.depth).collect{INDENT_MARKER}.join unless page.is_root?).to_s + page.title
    end.join("\n")
  end

  attr_accessible :name, :intro, :content_index  
  
  validates_presence_of :name, :on => :save
  validates_presence_of :creator_id, :on => :create
  validates_presence_of :updater_id, :on => :save
  validates_presence_of :slug, :on => :create
  #validates_presence_of :content_index, :on => :save, :allow_nil => false, :allow_blank => false
  validates :content_index, :presence => true
  
  after_create do |project|
    ancestors = []

    project.content_index.each_line do |title|
        title.strip =~ /^(-*)(.*)$/
        depth = $1.length
        title = $2
        p = project.pages.build(:title => title)
        ancestors.pop until ancestors.length <= depth
        p.parent_id = ancestors.last unless ancestors.empty?
        p.creator_id = project.creator_id

        p.save!
        ancestors.push(p.id)
    end
  end
  
  def to_param
    slug
  end

end