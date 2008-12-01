class Carts < Application
  # provides :xml, :yaml, :js

  def index
    @carts = Cart.all
    display @carts
  end

  def show(id)
    @cart = Cart.get(id)
    raise NotFound unless @cart
    display @cart
  end

  def new
    only_provides :html
    @cart = Cart.new
    display @cart
  end

  def edit(id)
    only_provides :html
    @cart = Cart.get(id)
    raise NotFound unless @cart
    display @cart
  end

  def create(cart)
    @cart = Cart.new(cart)
    if @cart.save
      redirect resource(@cart), :message => {:notice => "Cart was successfully created"}
    else
      message[:error] = "Cart failed to be created"
      render :new
    end
  end

  def update(id, cart)
    @cart = Cart.get(id)
    raise NotFound unless @cart
    if @cart.update_attributes(cart)
       redirect resource(@cart)
    else
      display @cart, :edit
    end
  end

  def destroy(id)
    @cart = Cart.get(id)
    raise NotFound unless @cart
    if @cart.destroy
      redirect resource(:carts)
    else
      raise InternalServerError
    end
  end

end # Carts
