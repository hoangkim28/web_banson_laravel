<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateAttributeValueProductAttributeTable extends Migration
{
    /**
     * Schema table name to migrate
     * @var string
     */
    public $tableName = 'attribute_value_product_attribute';

    /**
     * Run the migrations.
     * @table attribute_value_product_attribute
     *
     * @return void
     */
    public function up()
    {
        Schema::create($this->tableName, function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->unsignedBigInteger('attribute_value_id');
            $table->unsignedBigInteger('product_attribute_id');
            // $table->unique(['attribute_value_id', 'product_attribute_id'], 'patt');
            // $table->foreign('attribute_value_id','attr_val')->references('id')->on('attribute_values')->onDelete('cascade');
            // $table->foreign('product_attribute_id','pro_attr')->references('id')->on('product_attributes')->onDelete('cascade');
            // $table->primary(['attribute_value_id', 'product_attribute_id']);

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
