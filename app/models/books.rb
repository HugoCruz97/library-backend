class Books < ApplicationRecord
  self.table_name = "tb_books"
  self.sequence_name = "tb_books_seq"

  belongs_to :students
  belongs_to :rents
end
