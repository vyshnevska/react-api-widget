# module ActsAsTaggable
#   extend ActiveSupport::Concern

#   included do
#     has_many :taggings, as: :taggable, class_name: 'Tagging'
#     has_many :tags, through: :taggings, class_name: 'Tag'
#   end
# end

# module ActsAsTaggable

#   def self.included(base)
#     base.extend(ClassMethods)
#   end

#   module ClassMethods
#     has_many :taggings, as: :taggable, class_name: 'Tagging'
#     has_many :tags, through: :taggings, class_name: 'Tag'


#     def acts_as_taggable
#       self.send :include, ActsAsTaggable::InstanceMethods
#     end
#   end

#   module InstanceMethods


#   end
# end

# ActiveRecord::Base.send(:include, ActsAsTaggable)