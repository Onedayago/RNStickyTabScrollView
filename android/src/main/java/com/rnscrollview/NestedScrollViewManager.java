package com.rnscrollview;



import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.common.MapBuilder;
import com.facebook.react.module.annotations.ReactModule;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.UIManagerHelper;
import com.facebook.react.uimanager.ViewGroupManager;
import com.facebook.react.uimanager.ViewManagerDelegate;
import com.facebook.react.uimanager.annotations.ReactProp;
import com.facebook.react.uimanager.events.EventDispatcher;
import com.facebook.react.viewmanagers.RNScrollViewManagerDelegate;
import com.facebook.react.viewmanagers.RNScrollViewManagerInterface;
import com.facebook.react.uimanager.events.Event;

import java.util.Map;

@ReactModule(name = NestedScrollViewManager.NAME)
public class NestedScrollViewManager extends ViewGroupManager<NestedScrollView> implements RNScrollViewManagerInterface<NestedScrollView> {

    private final ViewManagerDelegate<NestedScrollView> mDelegate;

    static final String NAME = "RNScrollView";

    private static final String EVENT_NAME_ONCLICK = "onScroll";

    public NestedScrollViewManager(ReactApplicationContext context) {
        mDelegate = new RNScrollViewManagerDelegate<>(this);
    }

    @Nullable
    @Override
    protected ViewManagerDelegate<NestedScrollView> getDelegate() {
        return mDelegate;
    }

    @NonNull
    @Override
    public String getName() {
        return NestedScrollViewManager.NAME;
    }

    @NonNull
    @Override
    protected NestedScrollView createViewInstance(@NonNull ThemedReactContext context) {
        return new NestedScrollView(context);
    }

    @Override
    @ReactProp(name = "stickyHeight")
    public void setStickyHeight(NestedScrollView view, float value) {
        view.setStickyHeight(value);
    }

    @Override
    public void setContentHeight(NestedScrollView view, float value) {

    }

    @Override
    public void setBounces(NestedScrollView view, boolean value) {

    }

    @Override
    @ReactProp(name = "showIndicator")
    public void setShowIndicator(NestedScrollView view, boolean value) {
        view.setVerticalScrollBarEnabled(value);
        view.setHorizontalScrollBarEnabled(value);
    }

    @Override
    public void setScrollEnable(NestedScrollView view, boolean value) {

    }

    @Override
    @ReactProp(name = "scrollUp")
    public void setScrollUp(NestedScrollView view, boolean value) {
        view.setScrollUp(value);
    }

    @Override
    @ReactProp(name = "scrollDown")
    public void setScrollDown(NestedScrollView view, boolean value) {
        view.setScrollDown(value);
    }

    @Override
    protected void addEventEmitters(@NonNull ThemedReactContext reactContext, @NonNull NestedScrollView view) {
        view.setOnScrollChangeListener(new androidx.core.widget.NestedScrollView.OnScrollChangeListener() {
            @Override
            public void onScrollChange(androidx.core.widget.NestedScrollView v, int scrollX, int scrollY, int oldScrollX, int oldScrollY) {
                WritableMap data = Arguments.createMap();
                data.putDouble("x",scrollX);// key用于在RN中获取传递的数据
                data.putDouble("y",scrollY);// key用于在RN中获取传递的数据

                EventDispatcher eventDispatcher = UIManagerHelper.getEventDispatcherForReactTag(reactContext, view.getId());
                Event event = new Event(reactContext.getSurfaceId(), view.getId()) {
                    @Override
                    public String getEventName() {
                        return EVENT_NAME_ONCLICK;
                    }

                    @Nullable
                    @Override
                    protected WritableMap getEventData() {
                        return data;
                    }
                };

                eventDispatcher.dispatchEvent(event);

            }
        });
    }

    @Nullable
    @Override
    public Map<String, Object> getExportedCustomDirectEventTypeConstants() {
        return MapBuilder.of(EVENT_NAME_ONCLICK,MapBuilder.of("registrationName", EVENT_NAME_ONCLICK));
    }
}
