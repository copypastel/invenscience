class Orders < Application
  # provides :xml, :yaml, :js

  def index
    @orders = Order.all
    display @orders
  end

  def show(id)
    @order = Order.get(id)
    raise NotFound unless @order
    display @order
  end

  def new
    only_provides :html
    @order = Order.new
    display @order
  end

  def edit(id)
    only_provides :html
    @order = Order.get(id)
    raise NotFound unless @order
    display @order
  end

  def create(order)
    @order = Order.new(order)
    if @order.save
      redirect resource(@order), :message => {:notice => "Order was successfully created"}
    else
      message[:error] = "Order failed to be created"
      render :new
    end
  end

  def update(id, order)
    @order = Order.get(id)
    raise NotFound unless @order
    if @order.update_attributes(order)
       redirect resource(@order)
    else
      display @order, :edit
    end
  end

  def destroy(id)
    @order = Order.get(id)
    raise NotFound unless @order
    if @order.destroy
      redirect resource(:orders)
    else
      raise InternalServerError
    end
  end

end # Orders
