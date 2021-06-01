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
    public $tableName = 'attr_val_pro_attr';

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
            $table->unsignedBigInteger('attr_val_id');
            $table->unsignedBigInteger('pro_attr_id');
            $table->foreign('attr_val_id','attribute_values_foregin')->references('id')->on('attribute_values')->onDelete('cascade');
            $table->foreign('pro_attr_id','attribute_values_foregin2')->references('id')->on('product_attributes')->onDelete('cascade');
            $table->primary(['attr_val_id', 'pro_attr_id']);

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
