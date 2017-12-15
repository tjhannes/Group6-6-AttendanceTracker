.class public Lcom/android/tools/ir/server/Restarter;
.super Ljava/lang/Object;
.source "Restarter.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 60
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Landroid/app/Activity;)V
    .locals 0
    .param p0, "x0"    # Landroid/app/Activity;

    .prologue
    .line 60
    invoke-static {p0}, Lcom/android/tools/ir/server/Restarter;->updateActivity(Landroid/app/Activity;)V

    return-void
.end method

.method public static getActivities(Landroid/content/Context;Z)Ljava/util/List;
    .locals 16
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "foregroundOnly"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Z)",
            "Ljava/util/List",
            "<",
            "Landroid/app/Activity;",
            ">;"
        }
    .end annotation

    .prologue
    .line 202
    new-instance v12, Ljava/util/ArrayList;

    invoke-direct {v12}, Ljava/util/ArrayList;-><init>()V

    .line 204
    .local v12, "list":Ljava/util/List;, "Ljava/util/List<Landroid/app/Activity;>;"
    :try_start_0
    const-string/jumbo v14, "android.app.ActivityThread"

    invoke-static {v14}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v8

    .line 205
    .local v8, "activityThreadClass":Ljava/lang/Class;
    move-object/from16 v0, p0

    invoke-static {v0, v8}, Lcom/android/tools/ir/server/MonkeyPatcher;->getActivityThread(Landroid/content/Context;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v7

    .line 206
    .local v7, "activityThread":Ljava/lang/Object;
    const-string/jumbo v14, "mActivities"

    invoke-virtual {v8, v14}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v2

    .line 207
    .local v2, "activitiesField":Ljava/lang/reflect/Field;
    const/4 v14, 0x1

    invoke-virtual {v2, v14}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 210
    move-object/from16 v0, p0

    invoke-static {v0, v8, v7}, Lcom/android/tools/ir/server/Restarter;->hasAppCrashed(Landroid/content/Context;Ljava/lang/Class;Ljava/lang/Object;)Z

    move-result v14

    if-eqz v14, :cond_1

    .line 211
    new-instance v14, Ljava/util/ArrayList;

    invoke-direct {v14}, Ljava/util/ArrayList;-><init>()V

    move-object v12, v14

    .line 250
    .end local v2    # "activitiesField":Ljava/lang/reflect/Field;
    .end local v7    # "activityThread":Ljava/lang/Object;
    .end local v8    # "activityThreadClass":Ljava/lang/Class;
    .end local v12    # "list":Ljava/util/List;, "Ljava/util/List<Landroid/app/Activity;>;"
    :cond_0
    :goto_0
    return-object v12

    .line 215
    .restart local v2    # "activitiesField":Ljava/lang/reflect/Field;
    .restart local v7    # "activityThread":Ljava/lang/Object;
    .restart local v8    # "activityThreadClass":Ljava/lang/Class;
    .restart local v12    # "list":Ljava/util/List;, "Ljava/util/List<Landroid/app/Activity;>;"
    :cond_1
    invoke-virtual {v2, v7}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v10

    .line 217
    .local v10, "collection":Ljava/lang/Object;
    instance-of v14, v10, Ljava/util/HashMap;

    if-eqz v14, :cond_4

    .line 219
    move-object v0, v10

    check-cast v0, Ljava/util/HashMap;

    move-object v1, v0

    .line 220
    .local v1, "activities":Ljava/util/Map;
    invoke-interface {v1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v9

    .line 229
    .end local v1    # "activities":Ljava/util/Map;
    .local v9, "c":Ljava/util/Collection;
    :goto_1
    invoke-interface {v9}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v14

    :cond_2
    :goto_2
    invoke-interface {v14}, Ljava/util/Iterator;->hasNext()Z

    move-result v15

    if-eqz v15, :cond_0

    invoke-interface {v14}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    .line 230
    .local v4, "activityClientRecord":Ljava/lang/Object;
    invoke-virtual {v4}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    .line 231
    .local v5, "activityClientRecordClass":Ljava/lang/Class;
    if-eqz p1, :cond_3

    .line 232
    const-string/jumbo v15, "paused"

    invoke-virtual {v5, v15}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v13

    .line 233
    .local v13, "pausedField":Ljava/lang/reflect/Field;
    const/4 v15, 0x1

    invoke-virtual {v13, v15}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 234
    invoke-virtual {v13, v4}, Ljava/lang/reflect/Field;->getBoolean(Ljava/lang/Object;)Z

    move-result v15

    if-nez v15, :cond_2

    .line 238
    .end local v13    # "pausedField":Ljava/lang/reflect/Field;
    :cond_3
    const-string/jumbo v15, "activity"

    invoke-virtual {v5, v15}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    .line 239
    .local v6, "activityField":Ljava/lang/reflect/Field;
    const/4 v15, 0x1

    invoke-virtual {v6, v15}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 240
    invoke-virtual {v6, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/app/Activity;

    .line 241
    .local v3, "activity":Landroid/app/Activity;
    if-eqz v3, :cond_2

    .line 242
    invoke-interface {v12, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    .line 245
    .end local v2    # "activitiesField":Ljava/lang/reflect/Field;
    .end local v3    # "activity":Landroid/app/Activity;
    .end local v4    # "activityClientRecord":Ljava/lang/Object;
    .end local v5    # "activityClientRecordClass":Ljava/lang/Class;
    .end local v6    # "activityField":Ljava/lang/reflect/Field;
    .end local v7    # "activityThread":Ljava/lang/Object;
    .end local v8    # "activityThreadClass":Ljava/lang/Class;
    .end local v9    # "c":Ljava/util/Collection;
    .end local v10    # "collection":Ljava/lang/Object;
    :catch_0
    move-exception v11

    .line 246
    .local v11, "e":Ljava/lang/Throwable;
    const-string/jumbo v14, "InstantRun"

    const/4 v15, 0x5

    invoke-static {v14, v15}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v14

    if-eqz v14, :cond_0

    .line 247
    const-string/jumbo v14, "InstantRun"

    const-string/jumbo v15, "Error retrieving activities"

    invoke-static {v14, v15, v11}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .line 221
    .end local v11    # "e":Ljava/lang/Throwable;
    .restart local v2    # "activitiesField":Ljava/lang/reflect/Field;
    .restart local v7    # "activityThread":Ljava/lang/Object;
    .restart local v8    # "activityThreadClass":Ljava/lang/Class;
    .restart local v10    # "collection":Ljava/lang/Object;
    :cond_4
    :try_start_1
    sget v14, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v15, 0x13

    if-lt v14, v15, :cond_0

    instance-of v14, v10, Landroid/util/ArrayMap;

    if-eqz v14, :cond_0

    .line 223
    move-object v0, v10

    check-cast v0, Landroid/util/ArrayMap;

    move-object v1, v0

    .line 224
    .local v1, "activities":Landroid/util/ArrayMap;
    invoke-virtual {v1}, Landroid/util/ArrayMap;->values()Ljava/util/Collection;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-result-object v9

    .line 225
    .restart local v9    # "c":Ljava/util/Collection;
    goto :goto_1
.end method

.method public static getForegroundActivity(Landroid/content/Context;)Landroid/app/Activity;
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 195
    const/4 v1, 0x1

    invoke-static {p0, v1}, Lcom/android/tools/ir/server/Restarter;->getActivities(Landroid/content/Context;Z)Ljava/util/List;

    move-result-object v0

    .line 196
    .local v0, "list":Ljava/util/List;, "Ljava/util/List<Landroid/app/Activity;>;"
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x0

    :goto_0
    return-object v1

    :cond_0
    const/4 v1, 0x0

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/Activity;

    goto :goto_0
.end method

.method private static getPackageName(Ljava/lang/Class;Ljava/lang/Object;)Ljava/lang/String;
    .locals 4
    .param p0, "activityThreadClass"    # Ljava/lang/Class;
    .param p1, "activityThread"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NoSuchMethodException;,
            Ljava/lang/IllegalAccessException;,
            Ljava/lang/reflect/InvocationTargetException;
        }
    .end annotation

    .prologue
    const/4 v3, 0x0

    .line 289
    const-string/jumbo v1, "currentPackageName"

    new-array v2, v3, [Ljava/lang/Class;

    .line 290
    invoke-virtual {p0, v1, v2}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 291
    .local v0, "currentPackageNameMethod":Ljava/lang/reflect/Method;
    new-array v1, v3, [Ljava/lang/Object;

    invoke-virtual {v0, p1, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    return-object v1
.end method

.method private static hasAppCrashed(Landroid/content/Context;Ljava/lang/Class;Ljava/lang/Object;)Z
    .locals 7
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "activityThreadClass"    # Ljava/lang/Class;
    .param p2, "activityThread"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NoSuchMethodException;,
            Ljava/lang/IllegalAccessException;,
            Ljava/lang/reflect/InvocationTargetException;
        }
    .end annotation

    .prologue
    const/4 v4, 0x0

    .line 262
    if-eqz p0, :cond_0

    if-nez p2, :cond_1

    .line 282
    :cond_0
    :goto_0
    return v4

    .line 266
    :cond_1
    invoke-static {p1, p2}, Lcom/android/tools/ir/server/Restarter;->getPackageName(Ljava/lang/Class;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 268
    .local v0, "currentPackageName":Ljava/lang/String;
    const-string/jumbo v5, "activity"

    .line 269
    invoke-virtual {p0, v5}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/app/ActivityManager;

    .line 271
    .local v2, "manager":Landroid/app/ActivityManager;
    invoke-virtual {v2}, Landroid/app/ActivityManager;->getProcessesInErrorState()Ljava/util/List;

    move-result-object v3

    .line 272
    .local v3, "processesInErrorState":Ljava/util/List;, "Ljava/util/List<Landroid/app/ActivityManager$ProcessErrorStateInfo;>;"
    if-eqz v3, :cond_0

    .line 273
    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :cond_2
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_0

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/ActivityManager$ProcessErrorStateInfo;

    .line 274
    .local v1, "info":Landroid/app/ActivityManager$ProcessErrorStateInfo;
    iget-object v6, v1, Landroid/app/ActivityManager$ProcessErrorStateInfo;->processName:Ljava/lang/String;

    invoke-virtual {v6, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_2

    iget v6, v1, Landroid/app/ActivityManager$ProcessErrorStateInfo;->condition:I

    if-eqz v6, :cond_2

    .line 275
    const-string/jumbo v4, "InstantRun"

    const/4 v5, 0x2

    invoke-static {v4, v5}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 276
    const-string/jumbo v4, "InstantRun"

    const-string/jumbo v5, "App Thread has crashed, return empty activity list."

    invoke-static {v4, v5}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 278
    :cond_3
    const/4 v4, 0x1

    goto :goto_0
.end method

.method private static restartActivity(Landroid/app/Activity;)V
    .locals 4
    .param p0, "activity"    # Landroid/app/Activity;

    .prologue
    const/4 v3, 0x2

    .line 76
    const-string/jumbo v0, "InstantRun"

    invoke-static {v0, v3}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 77
    const-string/jumbo v0, "InstantRun"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "About to restart "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 81
    :cond_0
    :goto_0
    invoke-virtual {p0}, Landroid/app/Activity;->getParent()Landroid/app/Activity;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 82
    const-string/jumbo v0, "InstantRun"

    invoke-static {v0, v3}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 83
    const-string/jumbo v0, "InstantRun"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 85
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string/jumbo v2, " is not a top level activity; restarting "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 87
    invoke-virtual {p0}, Landroid/app/Activity;->getParent()Landroid/app/Activity;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string/jumbo v2, " instead"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 83
    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 90
    :cond_1
    invoke-virtual {p0}, Landroid/app/Activity;->getParent()Landroid/app/Activity;

    move-result-object p0

    goto :goto_0

    .line 94
    :cond_2
    invoke-virtual {p0}, Landroid/app/Activity;->recreate()V

    .line 95
    return-void
.end method

.method public static restartActivityOnUiThread(Landroid/app/Activity;)V
    .locals 1
    .param p0, "activity"    # Landroid/app/Activity;

    .prologue
    .line 63
    new-instance v0, Lcom/android/tools/ir/server/Restarter$1;

    invoke-direct {v0, p0}, Lcom/android/tools/ir/server/Restarter$1;-><init>(Landroid/app/Activity;)V

    invoke-virtual {p0, v0}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 73
    return-void
.end method

.method public static restartApp(Landroid/content/Context;Ljava/util/Collection;Z)V
    .locals 13
    .param p0, "appContext"    # Landroid/content/Context;
    .param p2, "toast"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/Collection",
            "<",
            "Landroid/app/Activity;",
            ">;Z)V"
        }
    .end annotation

    .prologue
    .local p1, "knownActivities":Ljava/util/Collection;, "Ljava/util/Collection<Landroid/app/Activity;>;"
    const/4 v12, 0x2

    .line 113
    invoke-interface {p1}, Ljava/util/Collection;->isEmpty()Z

    move-result v6

    if-nez v6, :cond_3

    .line 115
    invoke-static {p0}, Lcom/android/tools/ir/server/Restarter;->getForegroundActivity(Landroid/content/Context;)Landroid/app/Activity;

    move-result-object v1

    .line 117
    .local v1, "foreground":Landroid/app/Activity;
    if-eqz v1, :cond_4

    .line 120
    if-eqz p2, :cond_0

    .line 121
    const-string/jumbo v6, "Restarting app to apply incompatible changes"

    invoke-static {v1, v6}, Lcom/android/tools/ir/server/Restarter;->showToast(Landroid/app/Activity;Ljava/lang/String;)V

    .line 123
    :cond_0
    const-string/jumbo v6, "InstantRun"

    invoke-static {v6, v12}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v6

    if-eqz v6, :cond_1

    .line 124
    const-string/jumbo v6, "InstantRun"

    const-string/jumbo v7, "RESTARTING APP"

    invoke-static {v6, v7}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 127
    :cond_1
    move-object v0, v1

    .line 128
    .local v0, "context":Landroid/content/Context;
    new-instance v2, Landroid/content/Intent;

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    invoke-direct {v2, v0, v6}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 129
    .local v2, "intent":Landroid/content/Intent;
    const/4 v3, 0x0

    .line 130
    .local v3, "intentId":I
    const/high16 v6, 0x10000000

    invoke-static {v0, v3, v2, v6}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v5

    .line 132
    .local v5, "pendingIntent":Landroid/app/PendingIntent;
    const-string/jumbo v6, "alarm"

    invoke-virtual {v0, v6}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/app/AlarmManager;

    .line 133
    .local v4, "mgr":Landroid/app/AlarmManager;
    const/4 v6, 0x1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v8

    const-wide/16 v10, 0x64

    add-long/2addr v8, v10

    invoke-virtual {v4, v6, v8, v9, v5}, Landroid/app/AlarmManager;->set(IJLandroid/app/PendingIntent;)V

    .line 134
    const-string/jumbo v6, "InstantRun"

    invoke-static {v6, v12}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v6

    if-eqz v6, :cond_2

    .line 135
    const-string/jumbo v6, "InstantRun"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v8, "Scheduling activity "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string/jumbo v8, " to start after exiting process"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 150
    .end local v0    # "context":Landroid/content/Context;
    .end local v2    # "intent":Landroid/content/Intent;
    .end local v3    # "intentId":I
    .end local v4    # "mgr":Landroid/app/AlarmManager;
    .end local v5    # "pendingIntent":Landroid/app/PendingIntent;
    :cond_2
    :goto_0
    const/4 v6, 0x0

    invoke-static {v6}, Ljava/lang/System;->exit(I)V

    .line 152
    .end local v1    # "foreground":Landroid/app/Activity;
    :cond_3
    return-void

    .line 142
    .restart local v1    # "foreground":Landroid/app/Activity;
    :cond_4
    invoke-interface {p1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v6

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/app/Activity;

    const-string/jumbo v7, "Unable to restart app"

    invoke-static {v6, v7}, Lcom/android/tools/ir/server/Restarter;->showToast(Landroid/app/Activity;Ljava/lang/String;)V

    .line 143
    const-string/jumbo v6, "InstantRun"

    invoke-static {v6, v12}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v6

    if-eqz v6, :cond_2

    .line 144
    const-string/jumbo v6, "InstantRun"

    const-string/jumbo v7, "Couldn\'t find any foreground activities to restart for resource refresh"

    invoke-static {v6, v7}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method static showToast(Landroid/app/Activity;Ljava/lang/String;)V
    .locals 3
    .param p0, "activity"    # Landroid/app/Activity;
    .param p1, "text"    # Ljava/lang/String;

    .prologue
    .line 155
    const-string/jumbo v0, "InstantRun"

    const/4 v1, 0x2

    invoke-static {v0, v1}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 156
    const-string/jumbo v0, "InstantRun"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "About to show toast for activity "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string/jumbo v2, ": "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 158
    :cond_0
    new-instance v0, Lcom/android/tools/ir/server/Restarter$2;

    invoke-direct {v0, p0, p1}, Lcom/android/tools/ir/server/Restarter$2;-><init>(Landroid/app/Activity;Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 191
    return-void
.end method

.method private static updateActivity(Landroid/app/Activity;)V
    .locals 0
    .param p0, "activity"    # Landroid/app/Activity;

    .prologue
    .line 333
    invoke-static {p0}, Lcom/android/tools/ir/server/Restarter;->restartActivity(Landroid/app/Activity;)V

    .line 334
    return-void
.end method
