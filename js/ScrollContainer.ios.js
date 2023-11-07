
import React, {useRef, useState, forwardRef, useImperativeHandle} from "react";
import {Text, View, TouchableOpacity, Animated} from "react-native";
import RNScrollView from "rn-scrollview/js/RNScrollViewNativeComponent";
import ScrollView from "./ScrollView";
import RNPageScrollView, {Commands} from "rn-scrollview/js/RNPageScrollViewNativeComponent";
import PropTypes from 'prop-types';

const ScrollContainerIos = forwardRef((props, ref) => {

    const {containerHeight, containerWidth, Header, data, Tab, PageContent, onPageChange} = props;
    const [stickyHeight, setStickyHeight] = useState(0);
    const [tabHeight, setTabHeight] = useState(0);
    const [contentHeight, setContentHeight] = useState(0);
    const tabScroll = useRef(null);

    useImperativeHandle(ref,()=>({
        setPage: (index)=>{
            Commands.setContentOffset(tabScroll.current, index*containerWidth,0);
        }
    }))

    const renderHeader = () => {
        return(
            <View onLayout={(e)=>{
                setStickyHeight(e.nativeEvent.layout.height);
            }}>
                {Header?.()}
            </View>
        )
    }

    const renderPage = (item, index) => {
        return(
            <ScrollView key={index} containerWidth={containerWidth} containerHeight={containerHeight-tabHeight}>
                {PageContent?.(item, index)}
            </ScrollView>
        )
    }

    const renderContent = () => {
        return(
            <RNPageScrollView
                showsIndicator={false}
                bounce={false}
                style={{width: containerWidth, height: containerHeight-tabHeight}}
                contentWidth={containerWidth*data.length}
                onScroll={(e)=>{
                    onPageChange(parseInt(e.nativeEvent.x/containerWidth));
                }}
                ref={tabScroll}
            >
                <View style={{flexDirection: 'row', height: containerHeight-tabHeight}}>
                    {
                        data.map((item, index)=>{
                            return renderPage(item, index);
                        })
                    }
                </View>
            </RNPageScrollView>
        )
    }

    const renderTab = () => {
        return(
            <View style={{flexDirection: 'row'}} onLayout={(e)=>{
                setTabHeight(e.nativeEvent.layout.height);
            }}>
                {Tab?.()}
            </View>
        )
    }

    return(
        <RNScrollView
            style={{width: containerWidth, height: containerHeight}}
            stickyHeight={stickyHeight}
            showsIndicator={false}
            bounce={false}
            contentHeight={contentHeight}
        >
            <View onLayout={(e)=>{
                setContentHeight(e.nativeEvent.layout.height);
            }}>
                {renderHeader()}
                {renderTab()}
                {renderContent()}
            </View>
        </RNScrollView>
    )
});

ScrollContainerIos.defaultProps = {
    containerHeight: 0,
    containerWidth: 0,
    Header: ()=>{},
    Tab: ()=>{},
    PageContent: ()=>{},
    data: [],
    onPageChange: ()=>{},
}

ScrollContainerIos.propTypes = {
    containerHeight: PropTypes.number.isRequired,
    containerWidth: PropTypes.number.isRequired,
    Header: PropTypes.func.isRequired,
    data: PropTypes.array.isRequired,
    Tab: PropTypes.func.isRequired,
    PageContent: PropTypes.func.isRequired,
    onPageChange: PropTypes.func,
}

export default ScrollContainerIos;
