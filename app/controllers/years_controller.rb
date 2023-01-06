class YearsController < ApplicationController
  before_action :authenticate_user!

  def index
    @years = Year.all.where(user_id: current_user.id)
  end

  def new
    @year = Year.new
  end

  def show
    @months = Month.all.where(year_id: params[:id])
  end

  def create
    respond_to do |format|
      if current_user.nil?
        format.html { redirect_to new_user_session_path }
      else
        @year = Year.new({}.merge(year_params, { user_id: current_user.id }))

        if @year.save
          format.html { redirect_to years_path, notice: 'Ano foi criado com sucesso' }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def year_params
    params.require(:year).permit(:name)
  end
end
