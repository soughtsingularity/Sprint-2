db.createCollection("customers", {
    validator:{
        $jsonSchema:{
            bsonType: "object",
            required: ["name", "surname", "address", "cp", "municipality", "province", "telephone" ],
            properties: {
                name: {bsonType: "string"},
                surname: {bsonType: "string"},
                address: {bsonType: "string"},
                cp: {bsonType: "string"},
                municipality: {bsonType: "string"},
                province: {bsonType:"string"},
                telephone: {bsonType: "string"},
            }
        }
    },
    validationLevel: "strict",
    validationAction: "error"
});

db.createCollection("orders", {
    validator:{
        $jsonSchema:{
            bsonType:"object",
            required: ["store_id", "customer_id", "completion_date_time", "delivery", "pickup", "price", "notes", "products"],
            properties: {
                store_id: {bsonType: "objectId"},
                customer_id: { bsonType: "objectId" },
                completion_date_time:{bsonType: "date"},
                order_type: {
                    bsonType: "string",
                    enum: ["delivery", "pickup"]
                },
                price: {bsonType: "double"},
                notes: {bsonType: "string"},
                products: {
                    bsonType: "array",
                    items: {
                        bsonType: "object",
                        required: ["product_id", "quantity"],
                        properties: {
                            product_id: { bsonType: "objectId" },
                            quantity: { bsonType: "int" }
                        }
                    }
                },
                delivery_order: {
                    bsonType: "object",
                    required:["employee_id", "completion_date_time"],
                    properties: {
                        employee_id: {bsonType: "ObjectId"},
                        completion_date_time: {bsonType: "date"}
                    }
                }
            }
        }
    },
    validationLevel: "strict",
    validationAction: "error"
});

db.createCollection("products", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["product_name", "product_description", "product_image", "product_price", "product_type"],
            properties: {
                product_name: { bsonType: "string" },
                product_description: { bsonType: "string" },
                product_image: { bsonType: "string" }, 
                product_price: { bsonType: "double" },
                product_type: {
                    bsonType: "string", 
                    enum: ["pizza", "hamburguesa", "bebida"] 
                },
                pizza_details: {
                    bsonType: "object",
                    properties: {
                        categories: {
                            bsonType: "array",
                            items: { bsonType: "string" }
                        }
                    }
                }
                
            }
        }
    },
    validationLevel: "strict",
    validationAction: "error"
});

db.createCollection("stores", {
    validator:{
        jsonSchema:{
            bsonType:"object",
            required:["address", "cp", "municipality", "province"],
            properties:{
                address: {bsonType: "string"},
                cp: {bsonType: "string"},
                municipality: {bsonType: "string"},
                province: {bsonType: "string"},
                orders: {
                    bsonType: "array",
                    items: {
                        bsonType: "object",
                        required: ["order_id"],
                        properties: {
                            order_id: { bsonType: "objectId" },
                        }
                    }
                },
                employees:{
                    bsonType: "array",
                    items: {
                        bsonType: "object",
                        required: ["employee_id"],
                        properties:{
                            employee_id: {bsonType: "objectId"},
                        }
                    }
                } 

            }

        }
    }
});

db.createCollection("employees",{
    validator:{
        jsonSchema:{
            bsonType:"object",
            required:["name", "surname", "nif", "telephone", "job"],
            properties:{
                name: {bsonType: "string"},
                surname: {bsonType: "string"},
                nif: {bsonType: "string"},
                telephone: {bsonType: "string"},
                job: {
                    bsonType: "string",
                    enum:["courier", "cheff"]
                }
            }

        }
    }
});
