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
            $table->unsignedInteger('attribute_value_id');
            $table->unsignedInteger('product_attribute_id');

            $table->index(["attribute_value_id"], 'attribute_value_product_attribute_attribute_value_id_foreign');

            $table->index(["product_attribute_id"], 'attribute_value_product_attribute_product_attribute_id_foreign');
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
