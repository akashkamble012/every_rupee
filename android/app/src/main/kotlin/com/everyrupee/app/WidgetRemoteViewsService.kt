package com.everyrupee.app

import android.content.Context
import android.content.Intent
import android.widget.RemoteViews
import android.widget.RemoteViewsService
import es.antonborri.home_widget.HomeWidgetPlugin
import org.json.JSONArray
import org.json.JSONObject

class WidgetRemoteViewsService : RemoteViewsService() {
    override fun onGetViewFactory(intent: Intent): RemoteViewsFactory {
        return WidgetRemoteViewsFactory(this.applicationContext, intent)
    }
}

class WidgetRemoteViewsFactory(private val context: Context, intent: Intent) : RemoteViewsService.RemoteViewsFactory {
    
    private var transactions = mutableListOf<JSONObject>()

    override fun onCreate() {
        // Initially called
    }

    override fun onDataSetChanged() {
        // Fetch data from Flutter's shared preferences via HomeWidget
        val widgetData = HomeWidgetPlugin.getData(context)
        val jsonString = widgetData.getString("recent_transactions", "[]") ?: "[]"
        
        transactions.clear()
        try {
            val jsonArray = JSONArray(jsonString)
            for (i in 0 until jsonArray.length()) {
                transactions.add(jsonArray.getJSONObject(i))
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    override fun onDestroy() {
        transactions.clear()
    }

    override fun getCount(): Int = transactions.size

    override fun getViewAt(position: Int): RemoteViews {
        val tx = transactions[position]
        val rv = RemoteViews(context.packageName, R.layout.widget_transaction_item)
        
        val merchant = tx.optString("merchant", "Unknown")
        val amount = tx.optDouble("amount", 0.0)
        val type = tx.optString("type", "debit")
        
        rv.setTextViewText(R.id.tv_merchant, merchant)
        
        val amountStr = if (type == "credit") "+₹%.2f".format(amount) else "-₹%.2f".format(amount)
        rv.setTextViewText(R.id.tv_amount, amountStr)
        
        // Color amount based on type
        val colorId = if (type == "credit") android.graphics.Color.parseColor("#4CAF50") else android.graphics.Color.parseColor("#FF5252")
        rv.setTextColor(R.id.tv_amount, colorId)
        
        return rv
    }

    override fun getLoadingView(): RemoteViews? = null
    override fun getViewTypeCount(): Int = 1
    override fun getItemId(position: Int): Long = position.toLong()
    override fun hasStableIds(): Boolean = true
}
