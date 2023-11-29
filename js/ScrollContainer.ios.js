
import React, {useRef, useState, forwardRef, useImperativeHandle} from "react";
import {Text, View, TouchableOpacity, Animated, StyleSheet} from "react-native";
import RNScrollView from "./RNScrollViewNativeComponent";
import ScrollView from "./ScrollView";
import RNPageScrollView, {Commands} from "./RNPageScrollViewNativeComponent";
import PropTypes from 'prop-types';

const ScrollContainerIos = forwardRef((props, ref) => {

    const {Header, data, Tab, PageContent,
        onPageChange, scrollEnable,
        scrollDown, scrollUp, onTopScroll, headTop, viewStyle
    } = props;
    const [stickyHeight, setStickyHeight] = useState(0);
    const [tabHeight, setTabHeight] = useState(0);
    const [contentHeight, setContentHeight] = useState(0);
    const [containerWidth, setW] = useState(0);
    const [containerHeight, setH] = useState(0);
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
            <ScrollView key={index} containerWidth={containerWidth} containerHeight={(containerHeight-tabHeight-headTop)<0?0:(containerHeight-tabHeight-headTop)}>
                {PageContent?.(item, index)}
            </ScrollView>
        )
    }

    const renderContent = () => {
        return(
            <RNPageScrollView
                showsIndicator={false}
                bounce={false}
                style={{width: containerWidth, height: (containerHeight-tabHeight-headTop)<0?0:(containerHeight-tabHeight-headTop)}}
                contentWidth={containerWidth*data.length}
                onScroll={(e)=>{
                    onPageChange(parseInt(e.nativeEvent.x/containerWidth));
                }}
                ref={tabScroll}
                scrollEnable={scrollEnable}
            >
                <View style={{flexDirection: 'row', height: (containerHeight-tabHeight-headTop)<0?0:(containerHeight-tabHeight-headTop)}}>
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
        <View style={[styles.container, viewStyle]} onLayout={(e)=>{
            setW(e.nativeEvent.layout.width);
            setH(e.nativeEvent.layout.height);
        }}>
            <RNScrollView
                style={{width: containerWidth, height: containerHeight}}
                stickyHeight={(stickyHeight-headTop) < 0 ?0:parseInt((stickyHeight-headTop).toFixed(0))}
                showIndicator={false}
                bounces={false}
                contentHeight={contentHeight}
                scrollDown={scrollDown}
                scrollUp={scrollUp}
                onScroll={onTopScroll}
            >
                <View onLayout={(e)=>{
                    setContentHeight(e.nativeEvent.layout.height);
                }}>
                    {renderHeader()}
                    {renderTab()}
                    {renderContent()}
                </View>
            </RNScrollView>
        </View>
    )
});

ScrollContainerIos.defaultProps = {
    Header: ()=>{},
    Tab: ()=>{},
    PageContent: ()=>{},
    data: [],
    onPageChange: ()=>{},
    scrollEnable: false,
    scrollUp: true,
    scrollDown: true,
    onTopScroll: ()=>{},
    headTop: 0,
    viewStyle: {}
}

ScrollContainerIos.propTypes = {
    Header: PropTypes.func.isRequired,
    data: PropTypes.array.isRequired,
    Tab: PropTypes.func.isRequired,
    PageContent: PropTypes.func.isRequired,
    onPageChange: PropTypes.func,
    scrollEnable: PropTypes.bool,
    scrollUp: PropTypes.bool,
    scrollDown: PropTypes.bool,
    onTopScroll: PropTypes.func,
    headTop: PropTypes.number,
    viewStyle: PropTypes.object,
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
    }
})

export default ScrollContainerIos;
