<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateProductAttributesTable extends Migration
{
    /**
     * Schema table name to migrate
     * @var string
     */
    public $tableName = 'product_attributes';

    /**
     * Run the migrations.
     * @table product_attributes
     *
     * @return void
     */
    public function up()
    {
        Schema::create($this->tableName, function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->bigIncrements('id');
            $table->integer('quantity');
            $table->integer('price')->nullable()->default(null);
            $table->string('sale_price')->nullable()->default(null);
            $table->tinyInteger('default')->default('0');
            $table->unsignedBigInteger('product_id');

            $table->index(["product_id"], 'product_attributes_product_id_foreign');
            $table->nullableTimestamps();
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
