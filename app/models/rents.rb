class Rents < ApplicationRecord
  self.table_name = "tb_rents"
  self.sequence_name = "tb_rents_seq"

  has_many :books
  has_many :students
end
