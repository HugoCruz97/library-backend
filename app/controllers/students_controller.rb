class StudentsController < ApplicationController
  def create
    params.permit!
    s = params[:student]

    duplCode = Students.where(code: s[:code]).first

    render json: { error: "Código já existente" } and return if duplCode.present?

    ActiveRecord::Base.transaction do
      student = Students.new
      student.name = s[:name]
      student.class = s[:class]
      student.code = s[:code]

      student.save!
    end

    render json: { message: "Estudante criado com sucesso" }
  rescue => e
    render json: { error: "Erro ao criar estudante: #{e.message}" }
  end

  def get_students
    params.permit!

    students = Students.select(:id, :name).order(:name)

    render json: { students: students }
  rescue => e
    render json: { error: "Erro ao buscar estudantes: #{e.message}" }
  end

  def edit_students
    params.permit!
    s = params[:student]

    student = Students.where(id: s[:id]).first

    render json: { error: "Estudante não encontrado" } and return if student.blank?

    ActiveRecord::Base.transaction do
      student.name = s[:name] if s[:name].present?
      student.class = s[:class] if s[:class].present?
      student.code = s[:code] if s[:code].present?

      student.save!
    end

    render json: { message: "Estudante atualizado com sucesso" }
  rescue => e
    render json: { error: "Erro ao atualizar estudante: #{e.message}" }
  end

  def delete_student
    params.permit!

    student = Students.where(id: params[:id]).first

    render json: { error: "Estudante não encontrado" } and return if student.blank?

    is_rent = Rents.where(student_id: student.id).exists?

    render json: { error: "Estudante possui livros alugados e não pode ser deletado" } and return if is_rent

    ActiveRecord::Base.transaction do
      student.destroy!
    end

    render json: { message: "Estudante deletado com sucesso" }
  rescue => e
    render json: { error: "Erro ao deletar estudante: #{e.message}" }
  end
end
