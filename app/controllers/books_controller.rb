class BooksController < ApplicationController
  def create
    params.permit!
    b = params[:book]

    duplCode = Books.where(code: b[:code]).first

    render json: { error: "Código já existente" } and return if duplCode.present?

    ActiveRecord::Base.transaction do
      book = Books.new
      book.code = b[:code]
      book.title = b[:title]
      book.description = b[:description]
      book.author = b[:author]
      book.publisher = b[:publisher]
      book.quantity = b[:quantity]

      book.save!
    end

    render json: { message: "Livro criado com sucesso" }
  rescue => e
    render json: { error: "Erro ao criar livro: #{e.message}" }
  end

  def get_books
    params.permit!

    books = Books.all
    books = books.where(code: params[:code]) if params[:code].present?

    render json: { books: books }
  rescue => e
    render json: { error: "Erro ao buscar livros: #{e.message}" }
  end

  def delete_book
    params.permit!

    book = Books.where(id: params[:id]).first

    render json: { error: "Livro não encontrado" } and return if book.blank?

    is_rent = Rents.where(book_id: book.id).exists?

    render json: { error: "Livro está alugado e não pode ser deletado" } and return if is_rent

    ActiveRecord::Base.transaction do
      book.destroy!
    end

    render json: { message: "Livro deletado com sucesso" }
  rescue => e
    render json: { error: "Erro ao deletar livro: #{e.message}" }
  end

  def update_book
    params.permit!
    b = params[:book]

    book = Books.where(id: b[:id]).first

    render json: { error: "Livro não encontrado" } and return if book.blank?

    duplCode = Books.where(code: b[:code]).where.not(id: book.id).first

    render json: { error: "Código já existente" } and return if duplCode.present?

    ActiveRecord::Base.transaction do
      book.code = b[:code]
      book.title = b[:title]
      book.description = b[:description]
      book.author = b[:author]
      book.publisher = b[:publisher]
      book.quantity = b[:quantity]

      book.save!
    end

    render json: { message: "Livro atualizado com sucesso" }
  rescue => e
    render json: { error: "Erro ao atualizar livro: #{e.message}" }
  end
end
