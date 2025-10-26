class RentsController < ApplicationController
  def rent_book
    params.permit!
    r = params[:rent]

    quantity_book = Books.select(:quantity).where(id: r[:book_id]).first

    ActiveRecord::Base.transaction do
      rent = Rents.new
      rent.book_id = r[:book_id]
      rent.student_id = r[:student_id]
      rent.rent_time = r[:rent_time]

      rent.save!

      book_rented = Books.where(id: r[:book_id]).first
      book_rented.quantity = quantity_book.quantity - 1
      book_rented.save!
    end

    render json: { message: "Livro alugado com sucesso" }
  rescue => e
    render json: { error: "Erro ao alugar livro: #{e.message}" }
  end
end
