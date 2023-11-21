
import React, {useRef, useState, forwardRef, useImperativeHandle} from "react";
import {Text, View, TouchableOpacity, Animated, ScrollView, StyleSheet} from "react-native";
import RNScrollView from "./RNScrollViewNativeComponent";
import PropTypes from 'prop-types';

const ScrollContainerIos = forwardRef((props, ref) => {

    const {Header, data, Tab, PageContent, onPageChange, scrollEnable, scrollDown, scrollUp, onTopScroll, headTop, viewStyle} = props;
    const [stickyHeight, setStickyHeight] = useState(0);
    const [tabHeight, setTabHeight] = useState(0);
    const [containerWidth, setW] = useState(0);
    const [containerHeight, setH] = useState(0);
    const tabScroll = useRef(null);

    useImperativeHandle(ref,()=>({
        setPage: (index)=>{
            tabScroll.current.scrollTo({
                x: index*containerWidth,
                animated: true,
            })
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
            <View style={{width: containerWidth, height: containerHeight-tabHeight-headTop, overflow: 'hidden'}}  key={index}>
                <RNScrollView style={{width: containerWidth, height: containerHeight-tabHeight-headTop}} >
                    <View collapsable={false}>
                        {PageContent?.(item, index)}
                    </View>
                </RNScrollView>
            </View>

        )
    }

    const renderContent = () => {
        return(
            <ScrollView
                horizontal={true}
                pagingEnabled={true}
                scrollEnabled={scrollEnable}
                showsHorizontalScrollIndicator={false}
                ref={tabScroll}
                onMomentumScrollEnd={(e)=>{
                    onPageChange(Math.round(e.nativeEvent.contentOffset.x/containerWidth));
                }}
            >
                <View style={{flexDirection: 'row', height: containerHeight-tabHeight-headTop}}>
                    {
                        data.map((item, index)=>{
                            return renderPage(item, index);
                        })
                    }
                </View>
            </ScrollView>
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
                stickyHeight={stickyHeight-headTop}
                showIndicator={false}
                bounces={false}
                scrollDown={scrollDown}
                scrollUp={scrollUp}
                onScroll={onTopScroll}
            >
                <View  collapsable={false}>
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
    viewStyle: {},
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
        overflow: 'hidden'
    }
})

export default ScrollContainerIos;
