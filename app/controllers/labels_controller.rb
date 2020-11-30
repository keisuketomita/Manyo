class LabelsController < ApplicationController
  before_action :set_label, only: [:show, :edit, :update, :destroy]

  # GET /labels
  # GET /labels.json
  def index
    # @labels = Label.all.page(params[:page])
    @labels = current_user.labels.page(params[:page])
    @row_count = 1
  end

  # GET /labels/1
  # GET /labels/1.json
  def show
  end

  # GET /labels/new
  def new
    @label = Label.new
  end

  # GET /labels/1/edit
  def edit
  end

  # POST /labels
  # POST /labels.json
  def create
    @label = Label.new(label_params)
    @label.user_id = current_user.id
    if @label.save
      redirect_to labels_path, notice:"ラベルを登録しました"
    else
      render :new
    end

    # respond_to do |format|
    #   if @label.save
    #     format.html { redirect_to @label, notice: 'Label was successfully created.' }
    #     format.json { render :show, status: :created, location: @label }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @label.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /labels/1
  # PATCH/PUT /labels/1.json
  def update
    if @label.update(label_params)
      redirect_to labels_path, notice: "ラベルを編集しました"
    else
      render :edit
    end
    # respond_to do |format|
    #   if @label.update(label_params)
    #     format.html { redirect_to @label, notice: 'Label was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @label }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @label.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /labels/1
  # DELETE /labels/1.json
  def destroy
    @label.destroy
    redirect_to labels_path, notice: "ラベルを削除しました"
    # respond_to do |format|
    #   format.html { redirect_to labels_url, notice: 'Label was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_label
      @label = Label.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def label_params
      params.require(:label).permit(:name, :user_id)
    end
end
