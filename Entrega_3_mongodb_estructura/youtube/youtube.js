db.createCollection("users",{
    validator: {
        bsonType: "object",
        required: ["email", "password", "username", "born_date", "sex", "country", "cp"],
        properties:{
            email: {bsonType: "string"},
            password: {bsonType: "string"},
            username: {bsonType: "string"},
            born_date: {bsonType: "date"},
            sex: {bsonType: "string"},
            country: {bsonType: "string"},
            cp: {bsonType: "string"},
            playlists: { 
                bsonType: "array",
                items: { bsonType: "objectId" }
            }
        }
    },
    validationLevel: "strict",
    validationAction: "error"
});

db.users.createIndex({ email: 1 }, { unique: true });
db.users.createIndex({ username: 1 }, { unique: true });

db.createCollection("likes_dislikes", {
    validator: {
        bsonType: "object",
        required: ["user_id", "video_id", "action", "action_date"],
        properties: {
            user_id: { bsonType: "objectId" },
            video_id: { bsonType: "objectId" },
            action: {
                bsonType: "string",
                enum: ["like", "dislike"]
            },
            action_date: { bsonType: "date" }
        }
    },
    validationLevel: "strict",
    validationAction: "error"
});


db.likes_dislikes.createIndex({ user_id: 1, video_id: 1 }, { unique: true });
db.likes_dislikes.createIndex({ video_id: 1 });

db.createCollection("videos", {
    validator:{
        bsonType: "object",
        required: ["title", "description", "size", "file_name", "duration", "thumbnail", "reproductions",
            "likes", "dislikes", "status"],
        properties:{
            title: {bsonType: "string"},
            description: {bsonType: "string"},
            size: {bsonType: "long"},
            file_name: {bsonType: "string"},
            duration: {bsonType: "long"},
            thumbnail: {bsonType: "string"},
            reproductions: {bsonType: "long"},
            likes: {bsonType: "long"},
            dislikes: {bsonType: "long"},
            status: {
                bsonType: "string", 
                enum: ["public", "hidden", "private"] 
            },
            tags:{
                bsonType: "array",
                items: {bsonType: "string"}
            },
            published_by: {
                bsonType: "object",
                required:["user_id", "publication_date"],
                properties: {
                    user_id: {bsonType: "objectId"},
                    publication_date: {bsonType: "date"}
                }
            },
        }
    },
    validationLevel: "strict",
    validationAction: "error"

});

db.createCollection("channels", {
    validator: {
        bsonType: "object",
        required: ["name", "description", "creation_date", "created_by"],
        properties: {
            name: {bsonType: "string"},
            description: {bsonType: "string"},
            creation_date: {bsonType: "date"},
            created_by:{
                bsonType: "object",
                required: ["user_id"],
                properties: {
                    user_id: {bsonType: "objectId"}
                }
            },
        }

    },
    validationLevel: "strict",
    validationAction: "error"
});

db.channels.createIndex({ "created_by.user_id": 1 });


db.createCollection("playlists",{
    validator:{
        bsonType: "object",
        required:["name", "creation_date", "status", "user_id"],
        properties:{
            name: {bsonType: "string"},
            creation_date: {bsonType: "date"},
            status: {
                bsonType: "string", 
                enum: ["public", "private"] 
            },
            videos: { 
                bsonType: "array",
                items: { bsonType: "objectId" }
            },
            user_id: { 
                bsonType: "objectId" 
            }
        }
    },
    validationLevel: "strict",
    validationAction: "error"
});

db.playlists.createIndex({ user_id: 1 });


db.createCollection("comments", {
    validator: {
        bsonType: "object",
        required: ["text", "publication_date", "user_id", "video_id"],
        properties: {
            text: { bsonType: "string" },
            publication_date: { bsonType: "date" },
            user_id: { bsonType: "objectId" }, 
            video_id: { bsonType: "objectId" } 
        }
    },
    validationLevel: "strict",
    validationAction: "error"
});

db.comments.createIndex({ video_id: 1 });

db.createCollection("subscriptions", {
    validator: {
        bsonType: "object",
        required: ["user_id", "channel_id", "subscription_date"],
        properties: {
            user_id: { bsonType: "objectId" }, 
            channel_id: { bsonType: "objectId" }, 
            subscription_date: { bsonType: "date" }
        }
    },
    validationLevel: "strict",
    validationAction: "error"
});

db.subscriptions.createIndex({ user_id: 1, channel_id: 1 }, { unique: true });


