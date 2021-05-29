<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateOrderDetailsTable extends Migration
{
    /**
     * Schema table name to migrate
     * @var string
     */
    public $tableName = 'order_details';

    /**
     * Run the migrations.
     * @table order_details
     *
     * @return void
     */
    public function up()
    {
        Schema::create($this->tableName, function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->bigIncrements('id');
            $table->bigInteger('order_id')->unsigned();
            $table->bigInteger('product_id')->unsigned();
            $table->integer('quantity');
            $table->integer('product_price');
            $table->bigInteger('product_attribute_id')->unsigned()->nullable();
            $table->bigInteger('attribute_value_id')->unsigned()->nullable();
            $table->string('product_name', 100)->nullable()->default(null);
            $table->string('product_sku', 50)->nullable()->default(null);
            $table->string('color', 7)->nullable()->default(null);
            $table->foreign('order_id')->references('id')->on('orders');
            $table->foreign('product_id')->references('id')->on('products');
            $table->foreign('product_attribute_id')->references('id')->on('product_attributes');
            $table->foreign('attribute_value_id')->references('id')->on('attribute_values');

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists($this->tableName);
    }
}
