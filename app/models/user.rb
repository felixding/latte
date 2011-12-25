class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
  has_many :projects, :class_name => "Project", :foreign_key => "creator_id"
  
  validates_presence_of :name, :on => :update
  
  def owns?(object, options=nil)
    object_user_id = options[:column] ? object.send(options[:column]) : object.user_id
    self.id == object_user_id
  end
end
