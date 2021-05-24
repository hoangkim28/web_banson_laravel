<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateProductsTable extends Migration
{
    /**
     * Schema table name to migrate
     * @var string
     */
    public $tableName = 'products';

    /**
     * Run the migrations.
     * @table products
     *
     * @return void
     */
    public function up()
    {
        Schema::create($this->tableName, function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->bigIncrements('id');
            $table->bigInteger('category_id')->nullable()->default(null);
            $table->bigInteger('brand_id')->nullable()->default(null);
            $table->string('name', 100);
            $table->string('sku', 100);
            $table->string('seo_title', 100)->nullable()->default(null);
            $table->text('excerpt')->nullable()->default(null);
            $table->text('body');
            $table->string('avatar', 100);
            $table->string('slug', 100);
            $table->text('meta_description')->nullable()->default(null);
            $table->text('meta_keywords')->nullable()->default(null);
            $table->tinyInteger('featured')->default('0');
            $table->integer('sold')->nullable()->default('0');
            $table->integer('view')->nullable()->default(null);
            $table->dateTime('date_lastview');
            $table->dateTime('date_available');
            $table->integer('stock')->nullable()->default('0');

            $table->unique(["slug"], 'posts_slug_unique');
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
