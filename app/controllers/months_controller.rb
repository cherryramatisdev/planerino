class MonthsController < ApplicationController
  before_action :set_month, only: %i[show edit update destroy]

  # GET /months or /months.json
  def index
    @months = Month.all.sort { |a, b| sort_by_name(a, b) }
  end

  # GET /months/1 or /months/1.json
  def show
    @db_owners = Owner.all

    @owners = []

    @db_owners.each do |owner|
      debits_per_owner_and_month = Debit.all.where(month_id: params[:id], owner_id: owner.id)

      if debits_per_owner_and_month.empty?
        nil
      else
        @owners << owner
      end
    end

    @owners
  end

  # GET /months/new
  def new
    @month = Month.new
  end

  # GET /months/1/edit
  def edit; end

  # POST /months or /months.json
  def create
    respond_to do |format|
      if current_user.nil?
        format.html { redirect_to new_user_session_path }
      else
        @month = Month.new({}.merge(month_params, {user_id: current_user.id}))

        if @month.save
          format.html { redirect_to months_path, notice: 'Mês foi criado com sucesso' }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /months/1 or /months/1.json
  def update
    respond_to do |format|
      if @month.update(month_params)
        format.html { redirect_to months_path, notice: 'Mês foi atualizado com sucesso' }
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
      format.html { redirect_to months_url, notice: 'Mês foi excluido com sucesso' }
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

  # @param first [Month]
  # @param second [Month]
  def sort_by_name(first, second)
    Month::MONTH_NAMES[first.name.split[0]] <=> Month::MONTH_NAMES[second.name.split[0]]
  end
end
