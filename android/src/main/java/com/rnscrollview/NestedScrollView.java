package com.rnscrollview;

import android.content.Context;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.OverScroller;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.facebook.react.uimanager.MeasureSpecAssertions;
import com.facebook.react.uimanager.events.NativeGestureUtil;

public class NestedScrollView extends androidx.core.widget.NestedScrollView {

    private float maxScrollHeight = 0;

    private String mOverflow = "hidden";

    private OverScroller mScroller;

    private String TAG = "NestedScrollView";

    public NestedScrollView(@NonNull Context context) {
        super(context);
        mScroller = new OverScroller(context);
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        MeasureSpecAssertions.assertExplicitMeasureSpec(widthMeasureSpec, heightMeasureSpec);
        this.setMeasuredDimension(
                MeasureSpec.getSize(widthMeasureSpec),
                MeasureSpec.getSize(heightMeasureSpec)
        );
    }

    @Override
    public void onNestedPreScroll(@NonNull View target, int dx, int dy, @NonNull int[] consumed, int type) {
        super.onNestedPreScroll(target, dx, dy, consumed, type);
        //如果最大可滚动距离大于 0 则表示 scrollview 可以滚动，则去先消费用户滑动
        Log.d(TAG, String.valueOf(getScrollY()));
        if(this.maxScrollHeight > 0){
            //判断用户是否是向上滑动，并且没有超出 scrollview 可滑动的最大距离
            boolean headerScrollUp = dy > 0 && getScrollY() < this.maxScrollHeight;
            //判断用户是否是向下滑动，并且没有超出可滑动距离
            boolean headerScrollDown = dy < 0 && getScrollY() > 0;

            //如果 scrollview 可以滑动，则去消费滑动
            if (headerScrollUp || headerScrollDown) {
                scrollBy(0, dy);
                consumed[1] = dy;
                Log.d(TAG, "consume");
            }
        }
    }


    @Override
    public void scrollTo(int x, int y) {
        if(this.maxScrollHeight > 0){
            if (y < 0) {
                y = 0;
            }
            if (y > this.maxScrollHeight) {
                y = (int) this.maxScrollHeight;
            }
        }
        super.scrollTo(x, y);
    }

    public void setStickyHeight(float value) {
        this.maxScrollHeight = DensityUtil.dip2px(getContext(), value);
    }
}
