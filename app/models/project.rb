class Project < ActiveRecord::Base
  versioned :dependent => :tracking
  INDENT_MARKER = "\-"

  belongs_to :creator, :class_name => "User", :foreign_key => "creator_id"
  belongs_to :updater, :class_name => "User", :foreign_key => "updater_id"
  has_many :pages, :dependent => :destroy
  has_many :editions, :class_name => "Edition", :dependent => :destroy
  
  def content_index=(value)
    @content_index = value
  end

  def content_index
    @content_index ||= self.pages.all(:order => "index_id").collect do |page|
      ((0..page.depth - 1).collect{INDENT_MARKER}.join unless page.is_root?).to_s + page.id.to_s + "." + page.title
    end.join("\n")
  end

  attr_accessible :name, :intro, :content_index  
  
  validates_presence_of :name, :on => :save
  validates_presence_of :creator_id, :on => :create
  validates_presence_of :updater_id, :on => :save
  validates_presence_of :slug, :on => :create
  #validates_presence_of :content_index, :on => :save, :allow_nil => false, :allow_blank => false
  validates :content_index, :presence => true
  
  after_save do |project|
    ancestors = []
    index_id = 1

    project.content_index.each_line do |title|
        title.strip =~ /^(-*)(\d*)(\.?)(.*)$/
        depth = $1.length
        page_id = $2
        title = $4

        if page_id.blank?
          # new page
          p = project.pages.build(:title => title)
          p.creator_id = project.creator_id
        else
          # updating existing page
          p = project.pages.find(page_id)
        end
        
        p.index_id = index_id

        ancestors.pop until ancestors.length <= depth
        p.parent_id = ancestors.last unless ancestors.empty?
        p.updater_id = project.updater_id

        p.save!
        #unless p.save
          #raise p.errors.inspect unless p.errors.empty?
        #end

        ancestors.push(p.id)
        index_id += 1
    end
  end
  
  def to_param
    slug
  end

end