package com.mjstudio.reactnativenavermap.event

import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.WritableMap
import com.facebook.react.uimanager.events.Event

class NaverMapClusterTapEvent(
  surfaceId: Int,
  viewId: Int,
  private val identifierList: String,
) : Event<NaverMapClusterTapEvent>(surfaceId, viewId) {
  override fun getEventName(): String = EVENT_NAME

  override fun canCoalesce(): Boolean = false

  override fun getCoalescingKey(): Short = 0

  override fun getEventData(): WritableMap =
    Arguments.createMap().apply {
      putString("identifierList", identifierList)
    }

  companion object {
    const val EVENT_NAME = "topTapCluster"
  }
}
