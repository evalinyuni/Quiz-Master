class Exam
  include Mongoid::Document
  field :question, type: String
  field :answer, type: Integer
end
