package com.rnscrollview;


import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.module.annotations.ReactModule;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.ViewGroupManager;
import com.facebook.react.uimanager.ViewManagerDelegate;
import com.facebook.react.uimanager.annotations.ReactProp;
import com.facebook.react.viewmanagers.RNScrollViewManagerDelegate;
import com.facebook.react.viewmanagers.RNScrollViewManagerInterface;

@ReactModule(name = NestedScrollViewManager.NAME)
public class NestedScrollViewManager extends ViewGroupManager<NestedScrollView> implements RNScrollViewManagerInterface<NestedScrollView> {

    private final ViewManagerDelegate<NestedScrollView> mDelegate;

    static final String NAME = "RNScrollView";

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
    public void setHeight(NestedScrollView view, float value) {

    }

    @Override
    public void setWidth(NestedScrollView view, float value) {

    }

    @Override
    public void setContentHeight(NestedScrollView view, float value) {

    }

    @Override
    public void setBounces(NestedScrollView view, boolean value) {

    }

    @Override
    public void setShowIndicator(NestedScrollView view, boolean value) {

    }

}
