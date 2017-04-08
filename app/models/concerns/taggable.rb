module Concerns
  module Taggable
    extend ActiveSupport::Concern

    included do
      attr_accessor :tag_names

      has_many :taggings, as: :taggable, class_name: 'Tagging'
      has_many :tags, through: :taggings, class_name: 'Tag'

      before_save :save_tag_names

      def tag_names
        @tag_names || tags.pluck(:name).join(" ")
      end

      def save_tag_names
        self.tags = @tag_names.split.map { |name| Tag.where(name: name).first_or_create! } if @tag_names
      end
    end
  end
end