class DebitsController < ApplicationController
  before_action :set_debit, only: %i[show edit update destroy]

  # GET /debits or /debits.json
  def index
    @debits = Debit.all
  end

  # GET /debits/new
  def new
    @debit = Debit.new
  end

  # GET /debits/1/edit
  def edit; end

  # GET /update_paid
  def update_paid
    if params[:update_by_debit_title].nil?
      @updated = Debit.toggle_paid(params[:id])
      respond_to do |format|
        if @updated
          format.html { redirect_to month_path(params[:month_id]) }
        else
          format.json { render json: @updated.errors, status: :unprocessable_entity }
        end
      end
    else
      # TODO: Make this toggle smartly?
      debits_by_title = Debit.where(title: params[:update_by_debit_title])
      @updated = debits_by_title.update_all(paid: !debits_by_title.first.paid)
      respond_to do |format|
        if @updated
          format.html { redirect_to month_path(params[:month_id]) }
        else
          format.json { render json: @updated.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # POST /debits or /debits.json
  def create
    price = debit_params[:price].gsub(',', '.')
    @debit = create_new_debit_with_owner(debit_params[:owner_id], {
      title: debit_params[:title],
      price:,
      paid: debit_params[:paid],
      owner_id: debit_params[:owner_id],
      month_id: debit_params[:month_id]
    })

    respond_to do |format|
      if @debit.save
        format.html { redirect_to month_url(debit_params[:month_id]), notice: 'Debito foi adicionado com sucesso.' }
        format.json { render :show, status: :created, location: @debit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @debit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /debits/1 or /debits/1.json
  def update
    respond_to do |format|
      if @debit.update(debit_params)
        format.html { redirect_to debit_url(@debit), notice: 'Debito foi atualizado com sucesso' }
        format.json { render :show, status: :ok, location: @debit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @debit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /debits/1 or /debits/1.json
  def destroy
    @debit.destroy

    respond_to do |format|
      format.html { redirect_to debits_url, notice: 'Debito foi excluido com sucesso' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_debit
    @debit = Debit.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def debit_params
    params.require(:debit).permit(:id, :title, :price, :paid, :owner_id, :month_id)
  end

  def numeric?(target)
    !Float(target).nil?
  rescue StandardError
    false
  end

  def create_new_debit_with_owner(owner, obj_params)
    if numeric?(owner)
      @debit = Debit.new({
        title: obj_params[:title],
        price: obj_params[:price],
        paid: obj_params[:paid],
        owner_id: obj_params[:owner_id],
        month_id: obj_params[:month_id]
      })
    else
      owner = Owner.find_or_create_by(name: obj_params[:owner_id].upcase)
      @debit = Debit.new({
        title: obj_params[:title],
        price: obj_params[:price],
        paid: obj_params[:paid],
        owner_id: owner.id,
        month_id: obj_params[:month_id]
      })
    end
  end
end
