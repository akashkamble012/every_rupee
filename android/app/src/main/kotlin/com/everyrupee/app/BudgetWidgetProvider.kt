package com.everyrupee.app

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class BudgetWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: android.content.SharedPreferences) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_layout).apply {
                
                // Set up the intent that starts the WidgetRemoteViewsService, which will
                // provide the views for this collection.
                val intent = Intent(context, WidgetRemoteViewsService::class.java).apply {
                    putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, widgetId)
                    data = Uri.parse(toUri(Intent.URI_INTENT_SCHEME))
                }
                setRemoteAdapter(R.id.list_transactions, intent)
                
                // Set up Add Transaction button
                val pendingIntent = es.antonborri.home_widget.HomeWidgetLaunchIntent.getActivity(
                    context, 
                    MainActivity::class.java, 
                    Uri.parse("everyrupee://add_transaction")
                )
                setOnClickPendingIntent(R.id.btn_add_transaction, pendingIntent)
                
                // The empty view is displayed when the collection has no items.
                setEmptyView(R.id.list_transactions, R.id.tv_empty)
            }
            
            appWidgetManager.updateAppWidget(widgetId, views)
            appWidgetManager.notifyAppWidgetViewDataChanged(widgetId, R.id.list_transactions)
        }
    }
}
