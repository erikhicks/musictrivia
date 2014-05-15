class TriviaQuestionType < ActiveRecord::Base
	scope :model, -> (model) { where(answer_model: model) }
	scope :property, -> (property) { where(answer_property: property) }
end
