class MonthsController < ApplicationController
  before_action :set_month, only: %i[ show edit update destroy ]

  # GET /months or /months.json
  def index
    @months = Month.all
  end

  # GET /months/1 or /months/1.json
  def show
    @owners = Owner.all
  end

  # GET /months/new
  def new
    @month = Month.new
  end

  # GET /months/1/edit
  def edit
  end

  # POST /months or /months.json
  def create
    @month = Month.new(month_params)

    respond_to do |format|
      if @month.save
        format.html { redirect_to months_path, notice: "Mes foi criado com sucesso" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /months/1 or /months/1.json
  def update
    respond_to do |format|
      if @month.update(month_params)
        format.html { redirect_to months_path, notice: "Mes foi atualizado com sucesso" }
        format.json { render :show, status: :ok, location: @month }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @month.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /months/1 or /months/1.json
  def destroy
    @month.destroy

    respond_to do |format|
      format.html { redirect_to months_url, notice: "Mes foi excluido com sucesso" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_month
      @month = Month.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def month_params
      params.require(:month).permit(:name)
    end
end
