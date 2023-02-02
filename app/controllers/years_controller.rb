# frozen_string_literal: true

class YearsController < ApplicationController
  before_action :authenticate_user!

  def index
    @years = Year.all.where(user_id: current_user.id)
  end

  def new
    @year = Year.new
  end

  def show
    @year = Year.find(params[:id])
    @months = Month.all.where(year_id: params[:id], user_id: current_user.id).sort { |a, b| sort_by_name(a, b) }
  end

  def edit; end

  def update
    respond_to do |format|
      if @year.update(year_params)
        format.html { redirect_to years_path, notice: 'Ano foi atualizado com sucesso' }
        format.json { render :show, status: :ok, location: @year }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @year.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @year.destroy

    respond_to do |format|
      format.html { redirect_to years_path, notice: 'Ano foi excluido com sucesso' }
    end
  end

  def create
    respond_to do |format|
      @year = Year.new({}.merge(year_params, { user_id: current_user.id }))

      create_months_by_year(@year)

      if @year.save
        format.html { redirect_to year_path(@year.id), notice: 'Ano foi criado com sucesso' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def create_months_by_year(year)
    Month::MONTH_NAMES.each_key do |month|
      year.month.build(name: month, user_id: current_user.id).save
    end
  end

  # Only allow a list of trusted parameters through.
  def year_params
    params.require(:year).permit(:name)
  end
end
