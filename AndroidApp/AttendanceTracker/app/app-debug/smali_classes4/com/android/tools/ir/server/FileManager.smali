.class public Lcom/android/tools/ir/server/FileManager;
.super Ljava/lang/Object;
.source "FileManager.java"


# static fields
.field public static final CLASSES_DEX_SUFFIX:Ljava/lang/String; = ".dex"

.field private static final FILE_NAME_ACTIVE:Ljava/lang/String; = "active"

.field private static final FOLDER_NAME_LEFT:Ljava/lang/String; = "left"

.field private static final FOLDER_NAME_RIGHT:Ljava/lang/String; = "right"

.field private static final RELOAD_DEX_PREFIX:Ljava/lang/String; = "reload"

.field private static final RESOURCE_FILE_NAME:Ljava/lang/String; = "resources.ap_"

.field private static final RESOURCE_FOLDER_NAME:Ljava/lang/String; = "resources"

.field static final USE_EXTRACTED_RESOURCES:Z

.field private static havePurgedTempDexFolder:Z


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static delete(Ljava/io/File;)V
    .locals 6
    .param p0, "file"    # Ljava/io/File;

    .prologue
    .line 150
    invoke-virtual {p0}, Ljava/io/File;->isDirectory()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 152
    invoke-virtual {p0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v2

    .line 153
    .local v2, "files":[Ljava/io/File;
    if-eqz v2, :cond_0

    .line 154
    array-length v4, v2

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v4, :cond_0

    aget-object v0, v2, v3

    .line 155
    .local v0, "child":Ljava/io/File;
    invoke-static {v0}, Lcom/android/tools/ir/server/FileManager;->delete(Ljava/io/File;)V

    .line 154
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 161
    .end local v0    # "child":Ljava/io/File;
    .end local v2    # "files":[Ljava/io/File;
    :cond_0
    invoke-virtual {p0}, Ljava/io/File;->delete()Z

    move-result v1

    .line 162
    .local v1, "deleted":Z
    if-nez v1, :cond_1

    .line 163
    const-string/jumbo v3, "InstantRun"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v5, "Failed to delete file "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 165
    :cond_1
    return-void
.end method

.method public static extractZip(Ljava/io/File;[B)Z
    .locals 2
    .param p0, "destination"    # Ljava/io/File;
    .param p1, "zipBytes"    # [B

    .prologue
    .line 362
    const-string/jumbo v0, "InstantRun"

    const-string/jumbo v1, ""

    invoke-static {v0, v1}, Landroid/util/Log;->wtf(Ljava/lang/String;Ljava/lang/String;)I

    .line 363
    const/4 v0, 0x0

    return v0
.end method

.method public static finishUpdate(Z)V
    .locals 0
    .param p0, "wroteResources"    # Z

    .prologue
    .line 373
    if-eqz p0, :cond_0

    .line 374
    invoke-static {}, Lcom/android/tools/ir/server/FileManager;->swapFolders()V

    .line 376
    :cond_0
    return-void
.end method

.method public static getCheckSum(Ljava/io/File;)[B
    .locals 1
    .param p0, "file"    # Ljava/io/File;

    .prologue
    .line 514
    const/4 v0, 0x0

    return-object v0
.end method

.method public static getCheckSum(Ljava/lang/String;)[B
    .locals 1
    .param p0, "path"    # Ljava/lang/String;

    .prologue
    .line 471
    const/4 v0, 0x0

    return-object v0
.end method

.method private static getDataFolder()Ljava/io/File;
    .locals 2

    .prologue
    .line 93
    new-instance v0, Ljava/io/File;

    sget-object v1, Lcom/android/tools/ir/server/AppInfo;->applicationId:Ljava/lang/String;

    invoke-static {v1}, Lcom/android/tools/ir/runtime/Paths;->getDataDirectory(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    return-object v0
.end method

.method public static getExternalResourceFile()Ljava/io/File;
    .locals 3

    .prologue
    .line 217
    invoke-static {}, Lcom/android/tools/ir/server/FileManager;->getReadFolder()Ljava/io/File;

    move-result-object v1

    invoke-static {v1}, Lcom/android/tools/ir/server/FileManager;->getResourceFile(Ljava/io/File;)Ljava/io/File;

    move-result-object v0

    .line 218
    .local v0, "file":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_1

    .line 219
    const-string/jumbo v1, "InstantRun"

    const/4 v2, 0x2

    invoke-static {v1, v2}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 220
    const-string/jumbo v1, "InstantRun"

    const-string/jumbo v2, "Cannot find external resources, not patching them in"

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 222
    :cond_0
    const/4 v0, 0x0

    .line 225
    .end local v0    # "file":Ljava/io/File;
    :cond_1
    return-object v0
.end method

.method public static getFileSize(Ljava/lang/String;)J
    .locals 2
    .param p0, "path"    # Ljava/lang/String;

    .prologue
    .line 456
    const-wide/16 v0, -0x1

    return-wide v0
.end method

.method public static getNativeLibraryFolder()Ljava/io/File;
    .locals 3

    .prologue
    .line 112
    new-instance v0, Ljava/io/File;

    sget-object v1, Lcom/android/tools/ir/server/AppInfo;->applicationId:Ljava/lang/String;

    invoke-static {v1}, Lcom/android/tools/ir/runtime/Paths;->getMainApkDataDirectory(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string/jumbo v2, "lib"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method

.method public static getReadFolder()Ljava/io/File;
    .locals 3

    .prologue
    .line 120
    invoke-static {}, Lcom/android/tools/ir/server/FileManager;->leftIsActive()Z

    move-result v1

    if-eqz v1, :cond_0

    const-string/jumbo v0, "left"

    .line 121
    .local v0, "name":Ljava/lang/String;
    :goto_0
    new-instance v1, Ljava/io/File;

    invoke-static {}, Lcom/android/tools/ir/server/FileManager;->getDataFolder()Ljava/io/File;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    return-object v1

    .line 120
    .end local v0    # "name":Ljava/lang/String;
    :cond_0
    const-string/jumbo v0, "right"

    goto :goto_0
.end method

.method private static getResourceFile(Ljava/io/File;)Ljava/io/File;
    .locals 2
    .param p0, "base"    # Ljava/io/File;

    .prologue
    .line 99
    new-instance v0, Ljava/io/File;

    const-string/jumbo v1, "resources.ap_"

    invoke-direct {v0, p0, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    return-object v0
.end method

.method public static getTempDexFile()Ljava/io/File;
    .locals 15

    .prologue
    .line 232
    invoke-static {}, Lcom/android/tools/ir/server/FileManager;->getDataFolder()Ljava/io/File;

    move-result-object v1

    .line 233
    .local v1, "dataFolder":Ljava/io/File;
    invoke-static {v1}, Lcom/android/tools/ir/server/FileManager;->getTempDexFileFolder(Ljava/io/File;)Ljava/io/File;

    move-result-object v2

    .line 234
    .local v2, "dexFolder":Ljava/io/File;
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v10

    if-nez v10, :cond_4

    .line 235
    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    move-result v0

    .line 236
    .local v0, "created":Z
    if-nez v0, :cond_1

    .line 237
    const-string/jumbo v10, "InstantRun"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v12, "Failed to create directory "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 238
    const/4 v3, 0x0

    .line 283
    .end local v0    # "created":Z
    :cond_0
    :goto_0
    return-object v3

    .line 242
    .restart local v0    # "created":Z
    :cond_1
    const/4 v10, 0x1

    sput-boolean v10, Lcom/android/tools/ir/server/FileManager;->havePurgedTempDexFolder:Z

    .line 254
    .end local v0    # "created":Z
    :cond_2
    :goto_1
    invoke-virtual {v2}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v5

    .line 255
    .local v5, "files":[Ljava/io/File;
    const/4 v6, -0x1

    .line 258
    .local v6, "max":I
    if-eqz v5, :cond_5

    .line 259
    array-length v11, v5

    const/4 v10, 0x0

    :goto_2
    if-ge v10, v11, :cond_5

    aget-object v3, v5, v10

    .line 260
    .local v3, "file":Ljava/io/File;
    invoke-virtual {v3}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v8

    .line 261
    .local v8, "name":Ljava/lang/String;
    const-string/jumbo v12, "reload"

    invoke-virtual {v8, v12}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v12

    if-eqz v12, :cond_3

    const-string/jumbo v12, ".dex"

    invoke-virtual {v8, v12}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v12

    if-eqz v12, :cond_3

    .line 262
    const-string/jumbo v12, "reload"

    invoke-virtual {v12}, Ljava/lang/String;->length()I

    move-result v12

    .line 263
    invoke-virtual {v8}, Ljava/lang/String;->length()I

    move-result v13

    const-string/jumbo v14, ".dex"

    invoke-virtual {v14}, Ljava/lang/String;->length()I

    move-result v14

    sub-int/2addr v13, v14

    .line 262
    invoke-virtual {v8, v12, v13}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v7

    .line 265
    .local v7, "middle":Ljava/lang/String;
    :try_start_0
    invoke-static {v7}, Ljava/lang/Integer;->decode(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/Integer;->intValue()I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v9

    .line 266
    .local v9, "version":I
    if-le v9, v6, :cond_3

    .line 267
    move v6, v9

    .line 259
    .end local v7    # "middle":Ljava/lang/String;
    .end local v9    # "version":I
    :cond_3
    :goto_3
    add-int/lit8 v10, v10, 0x1

    goto :goto_2

    .line 249
    .end local v3    # "file":Ljava/io/File;
    .end local v5    # "files":[Ljava/io/File;
    .end local v6    # "max":I
    .end local v8    # "name":Ljava/lang/String;
    :cond_4
    sget-boolean v10, Lcom/android/tools/ir/server/FileManager;->havePurgedTempDexFolder:Z

    if-nez v10, :cond_2

    .line 250
    invoke-static {v1}, Lcom/android/tools/ir/server/FileManager;->purgeTempDexFiles(Ljava/io/File;)V

    goto :goto_1

    .line 275
    .restart local v5    # "files":[Ljava/io/File;
    .restart local v6    # "max":I
    :cond_5
    const-string/jumbo v10, "%s0x%04x%s"

    const/4 v11, 0x3

    new-array v11, v11, [Ljava/lang/Object;

    const/4 v12, 0x0

    const-string/jumbo v13, "reload"

    aput-object v13, v11, v12

    const/4 v12, 0x1

    add-int/lit8 v13, v6, 0x1

    invoke-static {v13}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v13

    aput-object v13, v11, v12

    const/4 v12, 0x2

    const-string/jumbo v13, ".dex"

    aput-object v13, v11, v12

    invoke-static {v10, v11}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    .line 277
    .local v4, "fileName":Ljava/lang/String;
    new-instance v3, Ljava/io/File;

    invoke-direct {v3, v2, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 279
    .restart local v3    # "file":Ljava/io/File;
    const-string/jumbo v10, "InstantRun"

    const/4 v11, 0x2

    invoke-static {v10, v11}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v10

    if-eqz v10, :cond_0

    .line 280
    const-string/jumbo v10, "InstantRun"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v12, "Writing new dex file: "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 269
    .end local v4    # "fileName":Ljava/lang/String;
    .restart local v7    # "middle":Ljava/lang/String;
    .restart local v8    # "name":Ljava/lang/String;
    :catch_0
    move-exception v12

    goto :goto_3
.end method

.method private static getTempDexFileFolder(Ljava/io/File;)Ljava/io/File;
    .locals 2
    .param p0, "base"    # Ljava/io/File;

    .prologue
    .line 108
    new-instance v0, Ljava/io/File;

    const-string/jumbo v1, "dex-temp"

    invoke-direct {v0, p0, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    return-object v0
.end method

.method public static getWriteFolder(Z)Ljava/io/File;
    .locals 6
    .param p0, "wipe"    # Z

    .prologue
    .line 137
    invoke-static {}, Lcom/android/tools/ir/server/FileManager;->leftIsActive()Z

    move-result v3

    if-eqz v3, :cond_1

    const-string/jumbo v2, "right"

    .line 138
    .local v2, "name":Ljava/lang/String;
    :goto_0
    new-instance v0, Ljava/io/File;

    invoke-static {}, Lcom/android/tools/ir/server/FileManager;->getDataFolder()Ljava/io/File;

    move-result-object v3

    invoke-direct {v0, v3, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 139
    .local v0, "folder":Ljava/io/File;
    if-eqz p0, :cond_0

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 140
    invoke-static {v0}, Lcom/android/tools/ir/server/FileManager;->delete(Ljava/io/File;)V

    .line 141
    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    move-result v1

    .line 142
    .local v1, "mkdirs":Z
    if-nez v1, :cond_0

    .line 143
    const-string/jumbo v3, "InstantRun"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v5, "Failed to create folder "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 146
    .end local v1    # "mkdirs":Z
    :cond_0
    return-object v0

    .line 137
    .end local v0    # "folder":Ljava/io/File;
    .end local v2    # "name":Ljava/lang/String;
    :cond_1
    const-string/jumbo v2, "left"

    goto :goto_0
.end method

.method private static leftIsActive()Z
    .locals 7

    .prologue
    const/4 v5, 0x1

    .line 168
    invoke-static {}, Lcom/android/tools/ir/server/FileManager;->getDataFolder()Ljava/io/File;

    move-result-object v0

    .line 169
    .local v0, "folder":Ljava/io/File;
    new-instance v3, Ljava/io/File;

    const-string/jumbo v6, "active"

    invoke-direct {v3, v0, v6}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 170
    .local v3, "pointer":Ljava/io/File;
    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v6

    if-nez v6, :cond_0

    .line 182
    :goto_0
    return v5

    .line 174
    :cond_0
    :try_start_0
    new-instance v4, Ljava/io/BufferedReader;

    new-instance v6, Ljava/io/FileReader;

    invoke-direct {v6, v3}, Ljava/io/FileReader;-><init>(Ljava/io/File;)V

    invoke-direct {v4, v6}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 176
    .local v4, "reader":Ljava/io/BufferedReader;
    :try_start_1
    invoke-virtual {v4}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v2

    .line 177
    .local v2, "line":Ljava/lang/String;
    const-string/jumbo v6, "left"

    invoke-virtual {v6, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v6

    .line 179
    :try_start_2
    invoke-virtual {v4}, Ljava/io/BufferedReader;->close()V

    move v5, v6

    .line 177
    goto :goto_0

    .line 179
    .end local v2    # "line":Ljava/lang/String;
    :catchall_0
    move-exception v6

    invoke-virtual {v4}, Ljava/io/BufferedReader;->close()V

    throw v6
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    .line 181
    .end local v4    # "reader":Ljava/io/BufferedReader;
    :catch_0
    move-exception v1

    .line 182
    .local v1, "ignore":Ljava/io/IOException;
    goto :goto_0
.end method

.method public static purgeTempDexFiles(Ljava/io/File;)V
    .locals 9
    .param p0, "dataFolder"    # Ljava/io/File;

    .prologue
    .line 424
    const/4 v4, 0x1

    sput-boolean v4, Lcom/android/tools/ir/server/FileManager;->havePurgedTempDexFolder:Z

    .line 426
    invoke-static {p0}, Lcom/android/tools/ir/server/FileManager;->getTempDexFileFolder(Ljava/io/File;)Ljava/io/File;

    move-result-object v1

    .line 427
    .local v1, "dexFolder":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->isDirectory()Z

    move-result v4

    if-nez v4, :cond_1

    .line 443
    :cond_0
    return-void

    .line 430
    :cond_1
    invoke-virtual {v1}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v3

    .line 431
    .local v3, "files":[Ljava/io/File;
    if-eqz v3, :cond_0

    .line 435
    array-length v5, v3

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v5, :cond_0

    aget-object v2, v3, v4

    .line 436
    .local v2, "file":Ljava/io/File;
    invoke-virtual {v2}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v6

    const-string/jumbo v7, ".dex"

    invoke-virtual {v6, v7}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_2

    .line 437
    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    move-result v0

    .line 438
    .local v0, "deleted":Z
    if-nez v0, :cond_2

    .line 439
    const-string/jumbo v6, "InstantRun"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v8, "Could not delete temp dex file "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 435
    .end local v0    # "deleted":Z
    :cond_2
    add-int/lit8 v4, v4, 0x1

    goto :goto_0
.end method

.method private static setLeftActive(Z)V
    .locals 8
    .param p0, "active"    # Z

    .prologue
    .line 187
    invoke-static {}, Lcom/android/tools/ir/server/FileManager;->getDataFolder()Ljava/io/File;

    move-result-object v2

    .line 188
    .local v2, "folder":Ljava/io/File;
    new-instance v3, Ljava/io/File;

    const-string/jumbo v5, "active"

    invoke-direct {v3, v2, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 189
    .local v3, "pointer":Ljava/io/File;
    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v5

    if-eqz v5, :cond_2

    .line 190
    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    move-result v1

    .line 191
    .local v1, "deleted":Z
    if-nez v1, :cond_0

    .line 192
    const-string/jumbo v5, "InstantRun"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v7, "Failed to delete file "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 203
    .end local v1    # "deleted":Z
    :cond_0
    :try_start_0
    new-instance v4, Ljava/io/BufferedWriter;

    new-instance v5, Ljava/io/OutputStreamWriter;

    new-instance v6, Ljava/io/FileOutputStream;

    invoke-direct {v6, v3}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    const-string/jumbo v7, "UTF-8"

    invoke-direct {v5, v6, v7}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;Ljava/lang/String;)V

    invoke-direct {v4, v5}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 206
    .local v4, "writer":Ljava/io/Writer;
    if-eqz p0, :cond_3

    :try_start_1
    const-string/jumbo v5, "left"

    :goto_0
    invoke-virtual {v4, v5}, Ljava/io/Writer;->write(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 208
    :try_start_2
    invoke-virtual {v4}, Ljava/io/Writer;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    .line 212
    .end local v4    # "writer":Ljava/io/Writer;
    :cond_1
    :goto_1
    return-void

    .line 194
    :cond_2
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v5

    if-nez v5, :cond_0

    .line 195
    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    move-result v0

    .line 196
    .local v0, "create":Z
    if-nez v0, :cond_1

    .line 197
    const-string/jumbo v5, "InstantRun"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v7, "Failed to create directory "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 206
    .end local v0    # "create":Z
    .restart local v4    # "writer":Ljava/io/Writer;
    :cond_3
    :try_start_3
    const-string/jumbo v5, "right"
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_0

    .line 208
    :catchall_0
    move-exception v5

    :try_start_4
    invoke-virtual {v4}, Ljava/io/Writer;->close()V

    throw v5
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_0

    .line 210
    .end local v4    # "writer":Ljava/io/Writer;
    :catch_0
    move-exception v5

    goto :goto_1
.end method

.method public static startUpdate()V
    .locals 1

    .prologue
    .line 369
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/android/tools/ir/server/FileManager;->getWriteFolder(Z)Ljava/io/File;

    .line 370
    return-void
.end method

.method public static swapFolders()V
    .locals 1

    .prologue
    .line 129
    invoke-static {}, Lcom/android/tools/ir/server/FileManager;->leftIsActive()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    invoke-static {v0}, Lcom/android/tools/ir/server/FileManager;->setLeftActive(Z)V

    .line 130
    return-void

    .line 129
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static writeAaptResources(Ljava/lang/String;[B)V
    .locals 7
    .param p0, "relativePath"    # Ljava/lang/String;
    .param p1, "bytes"    # [B

    .prologue
    .line 380
    const/4 v4, 0x0

    invoke-static {v4}, Lcom/android/tools/ir/server/FileManager;->getWriteFolder(Z)Ljava/io/File;

    move-result-object v4

    invoke-static {v4}, Lcom/android/tools/ir/server/FileManager;->getResourceFile(Ljava/io/File;)Ljava/io/File;

    move-result-object v3

    .line 381
    .local v3, "resourceFile":Ljava/io/File;
    move-object v1, v3

    .line 385
    .local v1, "file":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v2

    .line 386
    .local v2, "folder":Ljava/io/File;
    invoke-virtual {v2}, Ljava/io/File;->isDirectory()Z

    move-result v4

    if-nez v4, :cond_1

    .line 387
    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    move-result v0

    .line 388
    .local v0, "created":Z
    if-nez v0, :cond_1

    .line 389
    const-string/jumbo v4, "InstantRun"

    const/4 v5, 0x2

    invoke-static {v4, v5}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 390
    const-string/jumbo v4, "InstantRun"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v6, "Cannot create local resource file directory "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 406
    .end local v0    # "created":Z
    :cond_0
    :goto_0
    return-void

    .line 396
    :cond_1
    const-string/jumbo v4, "resources.ap_"

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 401
    invoke-static {v1, p1}, Lcom/android/tools/ir/server/FileManager;->writeRawBytes(Ljava/io/File;[B)Z

    goto :goto_0

    .line 404
    :cond_2
    invoke-static {v1, p1}, Lcom/android/tools/ir/server/FileManager;->writeRawBytes(Ljava/io/File;[B)Z

    goto :goto_0
.end method

.method public static writeRawBytes(Ljava/io/File;[B)Z
    .locals 6
    .param p0, "destination"    # Ljava/io/File;
    .param p1, "bytes"    # [B

    .prologue
    const/4 v5, 0x1

    .line 288
    :try_start_0
    new-instance v1, Ljava/io/BufferedOutputStream;

    new-instance v2, Ljava/io/FileOutputStream;

    invoke-direct {v2, p0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    invoke-direct {v1, v2}, Ljava/io/BufferedOutputStream;-><init>(Ljava/io/OutputStream;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 290
    .local v1, "output":Ljava/io/BufferedOutputStream;
    :try_start_1
    invoke-virtual {v1, p1}, Ljava/io/BufferedOutputStream;->write([B)V

    .line 291
    invoke-virtual {v1}, Ljava/io/BufferedOutputStream;->flush()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 294
    :try_start_2
    invoke-virtual {v1}, Ljava/io/BufferedOutputStream;->close()V

    .line 292
    return v5

    .line 294
    :catchall_0
    move-exception v2

    invoke-virtual {v1}, Ljava/io/BufferedOutputStream;->close()V

    throw v2
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    .line 296
    .end local v1    # "output":Ljava/io/BufferedOutputStream;
    :catch_0
    move-exception v0

    .line 297
    .local v0, "ioe":Ljava/io/IOException;
    const-string/jumbo v2, "InstantRun"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "Failed to write file, clean project and rebuild "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3, v0}, Landroid/util/Log;->wtf(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 301
    new-instance v2, Ljava/lang/RuntimeException;

    const-string/jumbo v3, "InstantRun could not write file %1$s, clean project and rebuild "

    new-array v4, v5, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object p0, v4, v5

    .line 302
    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method public static writeTempDexFile([B)Ljava/lang/String;
    .locals 3
    .param p0, "bytes"    # [B

    .prologue
    .line 410
    invoke-static {}, Lcom/android/tools/ir/server/FileManager;->getTempDexFile()Ljava/io/File;

    move-result-object v0

    .line 411
    .local v0, "file":Ljava/io/File;
    if-eqz v0, :cond_0

    .line 412
    invoke-static {v0, p0}, Lcom/android/tools/ir/server/FileManager;->writeRawBytes(Ljava/io/File;[B)Z

    .line 413
    invoke-virtual {v0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v1

    .line 417
    :goto_0
    return-object v1

    .line 415
    :cond_0
    const-string/jumbo v1, "InstantRun"

    const-string/jumbo v2, "No file to write temp dex content to"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 417
    const/4 v1, 0x0

    goto :goto_0
.end method
