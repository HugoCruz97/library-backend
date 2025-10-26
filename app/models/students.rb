class Students < ApplicationRecord
  self.table_name = "tb_students"
  self.sequence_name = "tb_students_seq"

  has_many :books
  has_many :rents
end
